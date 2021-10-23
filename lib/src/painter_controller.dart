import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'wave_definition.dart';

class PainterController extends ChangeNotifier {
  List<WaveDefinition> waves = [];

  void add(WaveDefinition wave) {
    if (waves.length == 6) {
      waves.clear();
    }
    waves.add(wave);
    notifyListeners();
  }
}
