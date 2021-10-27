class IOS7Options {
  const IOS7Options({this.amplitude = 1})
      : assert(amplitude >= 0 && amplitude <= 1);

  final double amplitude;

  @override
  String toString() => 'IOS7Options(amplitude: $amplitude)';
}
