import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  void enableAdminAccess(bool value) {
    _isAdmin = value;
    notifyListeners();
  }
}