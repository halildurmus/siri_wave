import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'models/ios_9_wave.dart';

class PainterController extends ChangeNotifier {
  List<IOS9Wave> waves = [];

  void add(IOS9Wave wave) {
    if (waves.length == 6) {
      waves.clear();
    }
    waves.add(wave);
    notifyListeners();
  }
}
