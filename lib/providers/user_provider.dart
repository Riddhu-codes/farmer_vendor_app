import 'package:flutter/material.dart';
import '../models/farmer.dart';
import '../models/vendor.dart';

class UserProvider with ChangeNotifier {
  Farmer? _farmer;
  Vendor? _vendor;
  bool _isFarmer = true;

  Farmer? get farmer => _farmer;
  Vendor? get vendor => _vendor;
  bool get isFarmer => _isFarmer;

  void setFarmer(Farmer farmer) {
    _farmer = farmer;
    _isFarmer = true;
    notifyListeners();
  }

  void setVendor(Vendor vendor) {
    _vendor = vendor;
    _isFarmer = false;
    notifyListeners();
  }

  void logout() {
    _farmer = null;
    _vendor = null;
    notifyListeners();
  }
}