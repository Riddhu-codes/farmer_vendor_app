import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/user_provider.dart';
import '../../services/firestore_service.dart';

class ManageOrders extends StatelessWidget {
  const ManageOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final firestore = FirestoreService();

    final farmer = userProvider.farmer;

    if (farmer == null || farmer.id == null) {
      return const Scaffold(
        body: Center(child: Text("Farmer not logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Orders"),
        backgroundColor: const Color(0xFF2E7D32),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          ),
        ),

        child: StreamBuilder<List<Order>>(
          stream: firestore.getOrdersForFarmer(farmer.id),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No orders found 📦",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            final orders = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // 🧾 ORDER INFO
                      Text(
                        "Order ID: ${order.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text("Crop: ${order.cropName}"),
                      Text("Qty: ${order.quantity}"),
                      Text("Total: ₹ ${order.totalPrice}"),

                      const SizedBox(height: 10),

                      // 📊 STATUS BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: order.status == 'pending'
                              ? Colors.orange
                              : order.status == 'accepted'
                                  ? Colors.green
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          order.status.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔘 ACTION BUTTONS
                      if (order.status == 'pending')
                        Row(
                          children: [

                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  firestore.updateOrderStatus(
                                      order.id, 'accepted');
                                },
                                child: const Text("Accept"),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  firestore.updateOrderStatus(
                                      order.id, 'rejected');
                                },
                                child: const Text("Reject"),
                              ),
                            ),
                          ],
                        ),

                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}