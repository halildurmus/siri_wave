import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/painting.dart' show Color, Path;

class PainterController extends ChangeNotifier {
  PainterController(this.color);

  final Color color;

  List<Path> paths = [];

  void add(Path path) {
    if (paths.length == 2) {
      paths.clear();
    }
    paths.add(path);
    notifyListeners();
  }
}
