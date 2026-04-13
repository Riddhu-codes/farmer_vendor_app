class Crop {
  String id;
  String farmerId;
  String name;
  double price;
  double quantity;
  String imageUrl;
  double lat;
  double lng;

  Crop({
    required this.id,
    required this.farmerId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'farmerId': farmerId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'lat': lat,
      'lng': lng,
    };
  }

  static Crop fromMap(Map<String, dynamic> map) {
    return Crop(
      id: map['id'],
      farmerId: map['farmerId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}