import 'package:flutter/foundation.dart';

class visibilityModel extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility(bool flag) {
    _isVisible = flag;
    notifyListeners();
  }
}
