import 'dart:math';
import 'package:flutter/foundation.dart';

class Dice extends ChangeNotifier {
  final List<int?> _values;
  final List<bool> _held;
  int _rollCount = 0;

  Dice(int numDice)
      : _values = List<int?>.filled(numDice, null),
        _held = List<bool>.filled(numDice, false);

  List<int> get values => _values.whereType<int>().toList();

  int get rollCount => _rollCount;

  int? operator [](int index) => _values[index];

  bool isHeld(int index) => _held[index];

  void clear() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = null;
      _held[i] = false;
    }
    _rollCount = 0;
    notifyListeners();
  }

  void roll() {
    if (_rollCount < 3) {
      for (var i = 0; i < _values.length; i++) {
        if (!_held[i]) {
          _values[i] = Random().nextInt(6) + 1;
        }
      }
      _rollCount++;
      notifyListeners();
    }
  }

  void toggleHold(int index) {
    _held[index] = !_held[index];
    notifyListeners();
  }

  void resetRollCount() {
    _rollCount = 0;
    notifyListeners();
  }
}

