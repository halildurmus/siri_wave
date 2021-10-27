import 'package:flutter/material.dart';

import 'ios_7/ios_7_siri_wave.dart';
import 'ios_9/ios_9_siri_wave.dart';
import 'models/siri_wave_options.dart';
import 'models/siri_wave_style.dart';

class SiriWave extends StatelessWidget {
  const SiriWave({
    Key? key,
    this.options = const SiriWaveOptions(),
    this.siriWaveStyle = SiriWaveStyle.ios_9,
  })  : super(key: key);

  final SiriWaveStyle siriWaveStyle;
  final SiriWaveOptions options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: options.height,
      width: options.width,
      child: DecoratedBox(
        decoration: BoxDecoration(color: options.backgroundColor),
        child: siriWaveStyle == SiriWaveStyle.ios_7
            ? IOS7SiriWave(options: options.ios7options)
            : IOS9SiriWave(options: options.ios9options),
      ),
    );
  }
}
