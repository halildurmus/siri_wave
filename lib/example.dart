import 'package:flutter/material.dart';

import 'siri_wave.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

List<Color> kColors = const [
  Color.fromRGBO(15, 82, 169, 1),
  Color.fromRGBO(48, 220, 155, 1),
  Color.fromRGBO(173, 57, 76, 1),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight / 2,
            child: const ClassicSiriWave(),
          ),
          SizedBox(
            height: deviceHeight / 2,
            child: Align(
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: CustomPaint(
                  painter: const SupportLinePainter(),
                  child: Stack(
                    children: [
                      IOS13SiriWave(color: kColors[0]),
                      IOS13SiriWave(color: kColors[1]),
                      IOS13SiriWave(color: kColors[2]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
