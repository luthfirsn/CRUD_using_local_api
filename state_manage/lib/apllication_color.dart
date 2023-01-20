import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApplicationColor with ChangeNotifier {
  bool _isGreenAccent = true;

  bool get isGreenAccent => _isGreenAccent;
  set isGreenAccent(bool value) {
    _isGreenAccent = value;
    notifyListeners();
  }

  Color get color => (_isGreenAccent) ? Colors.greenAccent : Colors.red;
}
