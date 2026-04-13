class Farmer {
  String id;
  String name;
  String phone;
  double lat;
  double lng;

  Farmer({required this.id, required this.name, required this.phone, required this.lat, required this.lng});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone, 'lat': lat, 'lng': lng};
  }

  static Farmer fromMap(Map<String, dynamic> map) {
    return Farmer(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}