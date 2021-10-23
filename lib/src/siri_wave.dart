import 'package:flutter/material.dart';
import 'package:siri_wave/src/siri_wave_style.dart';

import 'ios_7_siri_wave.dart';
import 'ios_9_siri_wave.dart';
import 'support_line_painter.dart';

class SiriWave extends StatelessWidget {
  const SiriWave({Key? key, this.siriWaveStyle = SiriWaveStyle.ios9})
      : super(key: key);

  final SiriWaveStyle siriWaveStyle;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: deviceHeight / 2,
      child: Align(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: CustomPaint(
            painter: const SupportLinePainter(),
            child: siriWaveStyle == SiriWaveStyle.ios7
                ? const IOS7SiriWave()
                : const IOS9SiriWave(),
          ),
        ),
      ),
    );
  }
}
