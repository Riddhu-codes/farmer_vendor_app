import 'package:flutter/material.dart';
import '../models/crop.dart';

class CropCard extends StatelessWidget {
  final Crop crop;
  final VoidCallback onTap;

  CropCard({required this.crop, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(crop.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(crop.name),
        subtitle: Text('Price: ₹${crop.price}/kg | Qty: ${crop.quantity}kg'),
        onTap: onTap,
      ),
    );
  }
}