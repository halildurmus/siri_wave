/// Describes the configuration for the iOS 9 Siri wave style.
class IOS9Options {
  const IOS9Options({this.amplitude = 1})
      : assert(amplitude >= 0 && amplitude <= 1);

  /// The amplitude of the waveform.
  ///
  /// Defaults to `1`.
  ///
  /// The value must be in the `[0, 1]` range.
  final double amplitude;

  @override
  String toString() => 'IOS9Options(amplitude: $amplitude)';
}
