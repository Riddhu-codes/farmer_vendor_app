class Vendor {
  String id;
  String name;
  String phone;

  Vendor({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  static Vendor fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}