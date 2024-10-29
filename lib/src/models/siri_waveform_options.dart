/// Represents the configuration options that can be used with the
/// `SiriWaveform` widget.
sealed class SiriWaveformOptions {
  /// Creates an instance of [SiriWaveformOptions].
  ///
  /// By default, the waveform has a [height] of `180` and a [width] of `360`.
  const SiriWaveformOptions({this.height = 180, this.width = 360});

  /// The height of the waveform.
  ///
  /// Defaults to `180`.
  final double height;

  /// The width of the waveform.
  ///
  /// Defaults to `360`.
  final double width;
}

/// Represents the configuration options for an *iOS 7 Siri-style* waveform.
final class IOS7SiriWaveformOptions extends SiriWaveformOptions {
  /// Creates an instance of [IOS7SiriWaveformOptions].
  ///
  /// By default, the waveform has a [height] of `180` and a [width] of `360`.
  const IOS7SiriWaveformOptions({super.height, super.width});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IOS7SiriWaveformOptions &&
          height == other.height &&
          width == other.width;

  @override
  int get hashCode => height.hashCode ^ width.hashCode;
}

/// Represents the configuration options for an *iOS 9 Siri-style* waveform.
final class IOS9SiriWaveformOptions extends SiriWaveformOptions {
  /// Creates an instance of [IOS9SiriWaveformOptions].
  ///
  /// By default, the waveform has a [height] of `180` and a [width] of `360`.
  ///
  /// Additionally, you can customize whether to show the support bar on the
  /// waveform using [showSupportBar]. By default, the support bar is shown.
  const IOS9SiriWaveformOptions({
    super.height,
    super.width,
    this.showSupportBar = true,
  });

  /// Determines whether to show the support bar on the waveform.
  ///
  /// Defaults to `true`.
  final bool showSupportBar;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IOS9SiriWaveformOptions &&
          height == other.height &&
          width == other.width &&
          showSupportBar == other.showSupportBar;

  @override
  int get hashCode => super.hashCode ^ showSupportBar.hashCode;
}
