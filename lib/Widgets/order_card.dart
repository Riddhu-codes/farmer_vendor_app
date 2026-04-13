import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  OrderCard({required this.order, required this.onAccept, required this.onReject});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Order ID: ${order.id}'),
        subtitle: Text('Status: ${order.status} | Qty: ${order.quantity}kg'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: onAccept, child: Text('Accept')),
            SizedBox(width: 8),
            ElevatedButton(onPressed: onReject, child: Text('Reject')),
          ],
        ),
      ),
    );
  }
}