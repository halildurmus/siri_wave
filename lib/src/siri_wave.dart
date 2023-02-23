import 'package:flutter/material.dart';

import 'ios_7/ios_7_siri_wave.dart';
import 'ios_9/ios_9_siri_wave.dart';
import 'models/siri_wave_controller.dart';
import 'models/siri_wave_options.dart';
import 'models/siri_wave_style.dart';

/// Displays a Siri style waveform.
class SiriWave extends StatefulWidget {
  /// Creates a Siri style waveform.
  ///
  /// The dimensions of the waveform can be configured with [options] or
  /// wrapping the [SiriWave] with either a [SizedBox], a [Container] or any
  /// other widget that constraints it's child.
  ///
  /// The style of the waveform can be configured with [style].
  /// By default, iOS 9 Siri style waveform is shown.
  SiriWave({
    SiriWaveController? controller,
    this.options = const SiriWaveOptions(),
    this.style = SiriWaveStyle.ios_9,
    super.key,
  }) : _controller = controller ?? SiriWaveController();

  /// See [SiriWaveController].
  final SiriWaveController _controller;

  /// See [SiriWaveStyle].
  final SiriWaveStyle style;

  /// See [SiriWaveOptions].
  final SiriWaveOptions options;

  @override
  State<SiriWave> createState() => _SiriWaveState();
}

class _SiriWaveState extends State<SiriWave> {
  late Widget _siriWave;

  void _setSiriWaveWidget() {
    _siriWave = widget.style == SiriWaveStyle.ios_7
        ? IOS7SiriWave(controller: widget._controller)
        : IOS9SiriWave(controller: widget._controller, options: widget.options);
  }

  @override
  void initState() {
    _setSiriWaveWidget();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SiriWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style ||
        oldWidget.options.showSupportBar != widget.options.showSupportBar) {
      _setSiriWaveWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.options.height,
      width: widget.options.width,
      child: _siriWave,
    );
  }
}
