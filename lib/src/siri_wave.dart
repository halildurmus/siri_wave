import 'package:flutter/material.dart';

import 'ios_7/ios_7_siri_wave.dart';
import 'ios_9/ios_9_siri_wave.dart';
import 'models/siri_wave_style.dart';

class SiriWave extends StatelessWidget {
  const SiriWave({
    Key? key,
    this.amplitude,
    this.siriWaveStyle = SiriWaveStyle.ios9,
  }) : super(key: key);

  final double? amplitude;
  final SiriWaveStyle siriWaveStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: siriWaveStyle == SiriWaveStyle.ios7
            ? IOS7SiriWave(amplitude: amplitude ?? .3)
            : IOS9SiriWave(amplitude: amplitude ?? 1),
      ),
    );
  }
}
