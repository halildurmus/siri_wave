class _Interpolation {
  _Interpolation(this.amplitude, this.speed);

  double? amplitude;
  double? speed;
}

class SiriWaveController {
  /// A controller for the waveform.
  ///
  /// Controls the `amplitude` and `speed` values of the waveform.
  SiriWaveController({this.amplitude = 1, this.speed = .2}) {
    _interpolation = _Interpolation(amplitude, speed);
  }

  /// The amplitude of the waveform.
  ///
  /// Defaults to `1`.
  ///
  /// The value must be in the `[0, 1]` range.
  double amplitude;

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

  /// Set a new interpolated value for the `speed`.
  void setSpeed(double newSpeed) => speed = newSpeed;
}
