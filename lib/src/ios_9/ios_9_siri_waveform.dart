import 'package:flutter/material.dart';

import '../models/siri_waveform_controller.dart';
import 'ios_9_siri_waveform_painter.dart';
import 'support_bar_painter.dart';

/// An *iOS 9 Siri-style* waveform.
class IOS9SiriWaveform extends StatefulWidget {
  /// Creates an instance of [IOS9SiriWaveform].
  ///
  /// The [controller] is responsible for controlling the properties and
  /// behavior of the waveform.
  ///
  /// Additionally, you can customize whether to show the support bar on the
  /// waveform using [showSupportBar]. By default, the support bar is shown.
  const IOS9SiriWaveform({
    required this.controller,
    super.key,
    this.showSupportBar = true,
  });

  /// The controller that manages the properties and behavior of the waveform.
  final IOS9SiriWaveformController controller;

  /// Determines whether to show the support bar on the waveform.
  ///
  /// Defaults to `true`.
  final bool showSupportBar;

  @override
  IOS9SiriWaveformState createState() => IOS9SiriWaveformState();
}

class IOS9SiriWaveformState extends State<IOS9SiriWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      // Since the AnimationController's value is not utilized in the animation,
      // the duration value does not impact the animation in any way.
      duration: const Duration(seconds: 1),
    );
    final IOS9SiriWaveformController(:amplitude, :speed) = widget.controller;
    if (amplitude > 0 && speed > 0) _animationController.repeat();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IOS9SiriWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isAnimating = _animationController.isAnimating;
    final IOS9SiriWaveformController(:amplitude, :speed) = widget.controller;
    if (isAnimating && (amplitude == 0 || speed == 0)) {
      _animationController.stop(canceled: false);
    } else if (!isAnimating && (amplitude > 0 && speed > 0)) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const supportBarPainter = IOS9SiriWaveformSupportBarPainter();
    final waveformPainter = IOS9SiriWaveformPainter(
      animationController: _animationController,
      controller: widget.controller,
    );
    final customPaint = CustomPaint(
      foregroundPainter:
          widget.controller.amplitude > 0 ? waveformPainter : null,
      painter: widget.showSupportBar ? supportBarPainter : null,
      size: Size.infinite,
    );

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) => customPaint,
    );
  }
}
