import 'package:flutter/material.dart';
import '../models/order.dart';

class PaymentScreen extends StatelessWidget {
  final Order order; // 🔹 required non-null

  const PaymentScreen({super.key, required this.order, required double amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            const SizedBox(height: 8),
            Text('Crop ID: ${order.cropId}'),
            const SizedBox(height: 8),
            Text('Farmer ID: ${order.farmerId}'),
            const SizedBox(height: 8),
            Text('Vendor ID: ${order.vendorId}'),
            const SizedBox(height: 8),
            Text('Quantity: ${order.quantity}'),
            const SizedBox(height: 8),
            Text('Status: ${order.status}'),
            const SizedBox(height: 8),
            Text('Timestamp: ${order.timestamp}'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 🔹 Payment logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful')),
                  );
                },
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
