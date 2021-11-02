import 'package:flutter/material.dart' show Color, Colors;

/// Describes the configuration will be used by [SiriWave].
class SiriWaveOptions {
  /// Creates a [SiriWaveOptions].
  const SiriWaveOptions({
    this.backgroundColor = Colors.black,
    this.height = 180,
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

  /// Width of the [SiriWave].
  ///
  /// Defaults to `360`.
  final double width;

  @override
  String toString() {
    return 'SiriWaveOptions(backgroundColor: $backgroundColor, height: $height, width: $width)';
  }
}
