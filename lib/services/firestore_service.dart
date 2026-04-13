import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '/models/crop.dart';
import '/models/farmer.dart';
import '/models/vendor.dart';
import '/models/order.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ GET ORDERS FOR FARMER
  Stream<List<Order>> getOrdersForFarmer(String farmerId) {
    return _db
        .collection('orders')
        .where('farmerId', isEqualTo: farmerId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Order.fromFirestore(doc);
          }).toList();
        });
  }

  // ✅ UPDATE ORDER STATUS
  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({
      'status': status,
    });
  }

  Future<void> addFarmer(Farmer farmer) async {}

  Future<void> addVendor(Vendor vendor) async {}

  Future<void> addCrop(Crop crop) async {}

  Future<dynamic> addOrder(Order tempOrder) async {}

  Stream<List<Crop>>? getCrops() {}
}
