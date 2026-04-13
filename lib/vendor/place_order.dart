import 'package:flutter/material.dart';
import '../models/crop.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/order.dart';
import 'package:farmer_vendor_app/services/payment_service.dart';

class PlaceOrder extends StatefulWidget {
  final Crop crop;

  const PlaceOrder({super.key, required this.crop});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final TextEditingController _quantityController = TextEditingController();

  Future<void> _placeOrder() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // SAFETY CHECKS
    if (userProvider.vendor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vendor not logged in")),
      );
      return;
    }

    if (_quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter quantity")),
      );
      return;
    }

    final quantity = double.tryParse(_quantityController.text);
    if (quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid quantity")),
      );
      return;
    }

    final firestore = FirestoreService();

    // TEMP order (without id)
    final tempOrder = Order(
      id: '',
      cropId: widget.crop.id,
      farmerId: widget.crop.farmerId,
      vendorId: userProvider.vendor!.id,
      quantity: quantity,
      status: 'pending',
      timestamp: DateTime.now(),
    );

    // 🔥 SAVE & GET FIRESTORE ID
    final orderId = await firestore.addOrder(tempOrder);

    // ✅ FINAL order with correct ID
    final order = Order(
      id: orderId,
      cropId: tempOrder.cropId,
      farmerId: tempOrder.farmerId,
      vendorId: tempOrder.vendorId,
      quantity: tempOrder.quantity,
      status: tempOrder.status,
      timestamp: tempOrder.timestamp,
    );

    if (!mounted) return;

    // 🚀 NAVIGATE
   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => PaymentScreen(
      order: order,
       amount: order.quantity * widget.crop.price,
    ),
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Place Order')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Crop: ${widget.crop.name}'),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _placeOrder,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
