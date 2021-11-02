import 'package:flutter/material.dart' show Color, Colors;

class _Interpolation {
  _Interpolation(this.amplitude, this.speed);

  double? amplitude;
  double? speed;
}

/// Controls the `amplitude`, `color`, `frequency` and `speed` of the waveform.
class SiriWaveController {
  /// Creates a [SiriWaveController].
  SiriWaveController({
    this.amplitude = 1,
    this.color = Colors.white,
    this.frequency = 6,
    this.speed = .2,
  })  : assert(amplitude >= 0 && amplitude <= 1),
        assert(frequency >= -20 && frequency <= 20),
        assert(speed >= 0 && speed <= 1) {
    _interpolation = _Interpolation(amplitude, speed);
  }

  /// The amplitude of the waveform.
  ///
  /// Defaults to `1.0`.
  ///
  /// The value must be in the `[0, 1]` range.
  double amplitude;

  /// The color of the iOS 7 style waveform.
  ///
  /// Defaults to `Colors.white`.
  Color color;

  /// The frequency of the iOS 7 style waveform.
  ///
  /// Defaults to `6`.
  ///
  /// The value must be in the `[-20, 20]` range.
  int frequency;

  /// The speed of the waveform.
  ///
  /// Defaults to `0.2`.
  ///
  /// The value must be in the `[0, 1]` range.
  double speed;

  late _Interpolation _interpolation;

  static const double _lerpSpeed = .1;

  double _intLerp(double v0, double v1, double t) => v0 * (1 - t) + v1 * t;

  // Interpolate `amplitude` and `speed` to the values in the `_interpolation`.
  void lerp() {
    final currentAmplitude = _interpolation.amplitude;
    if (currentAmplitude != null) {
      amplitude = _intLerp(amplitude, currentAmplitude, _lerpSpeed);
      if (amplitude - currentAmplitude == 0) {
        _interpolation.amplitude = null;
      }
    }

    final currentSpeed = _interpolation.amplitude;
    if (currentSpeed != null) {
      speed = _intLerp(speed, currentSpeed, _lerpSpeed);
      if (speed - currentSpeed == 0) {
        _interpolation.speed = null;
      }
    }
  }

  /// Set a new interpolated value for the `amplitude`.
  void setAmplitude(double newAmplitude) => amplitude = newAmplitude;

  /// Set a new color for the `color`.
  void setColor(Color newColor) => color = newColor;

  /// Set a new value for the `frequency`.
  void setFrequency(int newFrequency) => frequency = newFrequency;

  /// Set a new interpolated value for the `speed`.
  void setSpeed(double newSpeed) => speed = newSpeed;
}
