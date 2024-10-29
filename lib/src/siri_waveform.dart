import 'package:flutter/material.dart';

import 'ios_7/ios_7_siri_waveform.dart';
import 'ios_9/ios_9_siri_waveform.dart';
import 'models/siri_waveform_controller.dart';
import 'models/siri_waveform_options.dart';
import 'models/siri_waveform_style.dart';

/// A *Siri-style* waveform.
///
/// See also:
/// * [IOS7SiriWaveform], which is used to display an *iOS 7 Siri-style*
/// waveform.
/// * [IOS9SiriWaveform], which is used to display an *iOS 9 Siri-style*
/// waveform.
class SiriWaveform extends StatefulWidget {
  /// Creates a widget that displays an *iOS 7 Siri-style* waveform.
  ///
  /// [controller] can be used to change the `amplitude`, `color`, `frequency`,
  /// and `speed` of the waveform.
  ///
  /// The dimensions of the waveform can be customized by using [options] or by
  /// enclosing this widget within a [SizedBox], [Container], or any other
  /// widget that applies constraints to its child.
  SiriWaveform.ios7({
    IOS7SiriWaveformController? controller,
    IOS7SiriWaveformOptions? options,
    super.key,
  })  : controller = controller ?? IOS7SiriWaveformController(),
        options = options ?? const IOS7SiriWaveformOptions(),
        style = SiriWaveformStyle.ios_7;

  /// Creates a widget that displays an *iOS 9 Siri-style* waveform.
  ///
  /// [controller] can be used to change the `amplitude` and `speed` of the
  /// waveform.
  ///
  /// The dimensions of the waveform can be customized by using [options] or by
  /// enclosing this widget within a [SizedBox], [Container], or any other
  /// widget that applies constraints to its child.
  SiriWaveform.ios9({
    IOS9SiriWaveformController? controller,
    IOS9SiriWaveformOptions? options,
    super.key,
  })  : controller = controller ?? IOS9SiriWaveformController(),
        options = options ?? const IOS9SiriWaveformOptions(),
        style = SiriWaveformStyle.ios_9;

  /// See [SiriWaveformController].
  final SiriWaveformController controller;

  /// See [SiriWaveformOptions].
  final SiriWaveformOptions options;

  /// See [SiriWaveformStyle].
  final SiriWaveformStyle style;

  @override
  State<SiriWaveform> createState() => _SiriWaveformState();
}

class _SiriWaveformState extends State<SiriWaveform> {
  late Widget _siriWaveform;

  void _setSiriWaveformWidget() {
    final SiriWaveform(:controller, :options, :style) = widget;
    _siriWaveform = switch (style) {
      SiriWaveformStyle.ios_7 =>
        IOS7SiriWaveform(controller: controller as IOS7SiriWaveformController),
      SiriWaveformStyle.ios_9 => IOS9SiriWaveform(
          controller: controller as IOS9SiriWaveformController,
          showSupportBar: (options as IOS9SiriWaveformOptions).showSupportBar,
        ),
    };
  }

  @override
  void initState() {
    _setSiriWaveformWidget();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SiriWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    final SiriWaveform(
      controller: oldController,
      options: oldOptions,
      style: oldStyle
    ) = oldWidget;
    final SiriWaveform(:controller, :options, :style) = widget;
    if (oldController != controller ||
        oldOptions != options ||
        oldStyle != style) {
      _setSiriWaveformWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final SiriWaveformOptions(:height, :width) = widget.options;
    return SizedBox(height: height, width: width, child: _siriWaveform);
  }
}
