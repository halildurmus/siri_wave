import 'package:flutter/material.dart';

import 'ios_7_siri_wave_painter.dart';

class IOS7SiriWave extends StatefulWidget {
  const IOS7SiriWave({
    Key? key,
    required this.amplitude,
    this.frequency = 6,
    this.speed = .2,
  })  : assert(amplitude >= 0 && amplitude <= 1),
        assert(speed >= 0 && speed <= 1),
        super(key: key);

  final double amplitude;
  final int frequency;
  final double speed;

  @override
  _IOS7SiriWaveState createState() => _IOS7SiriWaveState();
}

class _IOS7SiriWaveState extends State<IOS7SiriWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    final _duration = widget.speed == 0 ? 0 : (64 / widget.speed).round();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration),
      upperBound: 6,
    );

    if (widget.amplitude > 0 && widget.speed > 0) {
      // We have to manually use the forward() to repeat the animation because
      // there is an issue with using repeat().
      // See https://github.com/flutter/flutter/issues/67507
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward(from: 0);
        }
      });
      _controller.forward();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IOS7SiriWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.isAnimating &&
        (widget.amplitude == 0 || widget.speed == 0)) {
      _controller.stop(canceled: false);
    } else if (!_controller.isAnimating &&
        (widget.amplitude > 0 && widget.speed > 0)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customPaint = CustomPaint(
      painter: IOS7SiriWavePainter(
        amplitude: widget.amplitude,
        controller: _controller,
        frequency: widget.frequency,
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => customPaint,
    );
  }
}
