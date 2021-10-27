class IOS9Options {
  const IOS9Options({this.amplitude = 1})
      : assert(amplitude >= 0 && amplitude <= 1);

  final double amplitude;

  @override
  String toString() => 'IOS9Options(amplitude: $amplitude)';
}
