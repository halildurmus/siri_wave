import 'package:flutter/material.dart' show Color, Colors;

/// A base class for controllers used to manage *Siri-style* waveforms.
///
/// See also:
/// * [IOS7SiriWaveformController], which manages *iOS 7 Siri-style* waveforms.
/// * [IOS9SiriWaveformController], which manages *iOS 9 Siri-style* waveforms.
sealed class SiriWaveformController {
  /// Creates an instance of [SiriWaveformController].
  ///
  /// The [amplitude] and [speed] properties can be adjusted to control the
  /// waveform's behavior.
  ///
  /// The [amplitude] defaults to `1.0` and must be within the `[0, 1]` range.
  ///
  /// The [speed] defaults to `0.2` and must be within the `[0, 1]` range.
  SiriWaveformController({this.amplitude = 1, this.speed = .2})
    : _interpolationAmplitude = amplitude,
      _interpolationSpeed = speed,
      assert(
        amplitude >= 0 && amplitude <= 1,
        'The amplitude must be in the [0, 1] range.',
      ),
      assert(
        speed >= 0 && speed <= 1,
        'The speed must be in the [0, 1] range.',
      );

  /// The amplitude of the waveform.
  ///
  /// Defaults to `1.0`.
  ///
  /// The value must be in the `[0, 1]` range.
  double amplitude;

  /// The speed of the waveform.
  ///
  /// Defaults to `0.2`.
  ///
  /// The value must be in the `[0, 1]` range.
  double speed;

  double? _interpolationAmplitude;
  double? _interpolationSpeed;

  static const double _lerpSpeed = .1;

  double _intLerp(double v0, double v1, double t) => v0 * (1 - t) + v1 * t;

  /// Interpolates the [amplitude] and [speed] values.
  void lerp() {
    final interpolationAmplitude = _interpolationAmplitude;
    if (interpolationAmplitude != null) {
      amplitude = _intLerp(amplitude, interpolationAmplitude, _lerpSpeed);
      if (amplitude - interpolationAmplitude == 0) {
        _interpolationAmplitude = null;
      }
    }

    final interpolationSpeed = _interpolationSpeed;
    if (interpolationSpeed != null) {
      speed = _intLerp(speed, interpolationSpeed, _lerpSpeed);
      if (speed - interpolationSpeed == 0) {
        _interpolationSpeed = null;
      }
    }
  }
}

/// A controller for managing *iOS 7 Siri-style* waveforms.
///
/// Use this controller to adjust properties like [amplitude], [color],
/// [frequency], and [speed] of the waveform.
final class IOS7SiriWaveformController extends SiriWaveformController {
  /// Creates an instance of [IOS7SiriWaveformController].
  ///
  /// The [amplitude], [speed], [color], and [frequency] properties can be
  /// adjusted to control the waveform's behavior.
  ///
  /// The [amplitude] defaults to `1.0` and must be within the `[0, 1]` range.
  ///
  /// The [speed] defaults to `0.2` and must be within the `[0, 1]` range.
  ///
  /// The [color] defaults to [Colors.white].
  ///
  /// The [frequency] defaults to `6` and must be within the `[-20, 20]` range.
  IOS7SiriWaveformController({
    super.amplitude,
    super.speed,
    this.color = Colors.white,
    this.frequency = 6,
  }) : assert(
         frequency >= -20 && frequency <= 20,
         'The frequency must be in the [-20, 20] range.',
       );

  /// The color of the waveform.
  ///
  /// Defaults to [Colors.white].
  Color color;

  /// The frequency of the waveform.
  ///
  /// Defaults to `6`.
  ///
  /// The value must be in the `[-20, 20]` range.
  int frequency;
}

/// A controller for managing *iOS 9 Siri-style* waveforms.
///
/// This controller allows you to adjust properties like [amplitude], [speed],
/// and the waveform's colors ([color1], [color2], and [color3]).
final class IOS9SiriWaveformController extends SiriWaveformController {
  /// Creates an instance of [IOS9SiriWaveformController].
  ///
  /// The [amplitude] and [speed] properties control the waveform's behavior,
  /// and the [color1], [color2], and [color3] properties define the colors used
  /// in the waveform.
  ///
  /// The [amplitude] defaults to `1.0` and must be within the `[0, 1]` range.
  ///
  /// The [speed] defaults to `0.2` and must be within the `[0, 1]` range.
  IOS9SiriWaveformController({
    super.amplitude,
    super.speed,
    this.color1 = const Color(0xFFAD394C),
    this.color2 = const Color(0xFF30DC9B),
    this.color3 = const Color(0xFF0F52A9),
  });

  /// The primary color of the waveform.
  ///
  /// This color is used for the main waveform curve. Defaults to
  /// `Color(0xFFAD394C)`.
  Color color1;

  /// The secondary color of the waveform.
  ///
  /// This color is used for the second waveform curve. Defaults to
  /// `Color(0xFF30DC9B)`.
  Color color2;

  /// The tertiary color of the waveform.
  ///
  /// This color is used for the third waveform curve. Defaults to
  /// `Color(0xFF0F52A9)`.
  Color color3;
}
