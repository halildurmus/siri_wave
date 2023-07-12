/// Describes the configuration will be used by the `SiriWave` widget.
class SiriWaveOptions {
  const SiriWaveOptions(
      {this.height = 180, this.showSupportBar = true, this.width = 360});

  /// Height of the waveform.
  ///
  /// Defaults to `180`.
  final double height;

  /// Whether to show the support bar on the iOS 9 style waveform.
  ///
  /// Defaults to `true`.
  final bool showSupportBar;

  /// Width of the waveform.
  ///
  /// Defaults to `360`.
  final double width;
}
