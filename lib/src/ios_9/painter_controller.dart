import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'ios_9_wave.dart';

class PainterController extends ChangeNotifier {
  var _waves = <IOS9Wave>[];

  List<IOS9Wave> get waves => _waves;

  set waves(List<IOS9Wave> waves) {
    _waves = waves;
    notifyListeners();
  }

  @override
  String toString() => 'PainterController(_waves: $_waves)';
}
