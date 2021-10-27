import 'package:flutter/material.dart' show Color, Colors;

import '../ios_7/ios7_options.dart';
import '../ios_9/ios9_options.dart';

class SiriWaveOptions {
  const SiriWaveOptions({
    this.backgroundColor = Colors.black,
    this.height = 180,
    this.ios7options = const IOS7Options(),
    this.ios9options = const IOS9Options(),
    this.width = 360,
  });

  final Color backgroundColor;
  final double height;
  final IOS7Options ios7options;
  final IOS9Options ios9options;
  final double width;

  @override
  String toString() {
    return 'SiriWaveOptions(backgroundColor: $backgroundColor, height: $height, ios7options: $ios7options, ios9options: $ios9options, width: $width)';
  }
}
