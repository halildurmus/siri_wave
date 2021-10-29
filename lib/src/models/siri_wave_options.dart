import 'package:flutter/material.dart' show Color, Colors;

import '../ios_7/ios_7_options.dart';
import '../ios_9/ios_9_options.dart';

/// Describes the configuration will be used by [SiriWave].
class SiriWaveOptions {
  const SiriWaveOptions({
    this.backgroundColor = Colors.black,
    this.height = 180,
    this.ios7Options = const IOS7Options(),
    this.ios9Options = const IOS9Options(),
    this.width = 360,
  });

  /// Background color of the [SiriWave].
  ///
  /// Defaults to `Colors.black`.
  final Color backgroundColor;

  /// Height of the [SiriWave].
  ///
  /// Defaults to `180`.
  final double height;

  /// See [IOS7Options].
  final IOS7Options ios7Options;

  /// See [IOS9Options].
  final IOS9Options ios9Options;

  /// Width of the [SiriWave].
  ///
  /// Defaults to `360`.
  final double width;

  @override
  String toString() {
    return 'SiriWaveOptions(backgroundColor: $backgroundColor, height: $height, ios7Options: $ios7Options, ios9Options: $ios9Options, width: $width)';
  }
}
