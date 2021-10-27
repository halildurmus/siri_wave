import 'package:flutter/material.dart';

import 'ios_7/ios_7_siri_wave.dart';
import 'ios_9/ios_9_siri_wave.dart';
import 'models/siri_wave_style.dart';

class SiriWave extends StatelessWidget {
  const SiriWave({
    Key? key,
    this.amplitude = 1,
    this.backgroundColor = Colors.black,
    this.height = 180,
    this.siriWaveStyle = SiriWaveStyle.ios9,
    this.width = 360,
  })  : assert(amplitude >= 0 && amplitude <= 1),
        super(key: key);

  final double amplitude;
  final Color backgroundColor;
  final double height;
  final SiriWaveStyle siriWaveStyle;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor),
        child: siriWaveStyle == SiriWaveStyle.ios7
            ? IOS7SiriWave(amplitude: amplitude)
            : IOS9SiriWave(amplitude: amplitude),
      ),
    );
  }
}
