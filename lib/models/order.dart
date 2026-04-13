import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String cropId;
  final String farmerId;
  final String vendorId;
  final double quantity;
  final String status;
  final DateTime timestamp;

  Order({
    required this.id,
    required this.cropId,
    required this.farmerId,
    required this.vendorId,
    required this.quantity,
    required this.status,
    required this.timestamp,
  });

  // 🔥 VERY IMPORTANT
 factory Order.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  return Order(
    id: doc.id,
    cropId: data['cropId'],
    farmerId: data['farmerId'],
    vendorId: data['vendorId'],
    quantity: (data['quantity'] as num).toDouble(),
    status: data['status'],
    timestamp: (data['timestamp'] as Timestamp).toDate(),
  );
}

  get cropName => null;

  get totalPrice => null;
}