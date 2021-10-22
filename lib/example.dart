import 'package:flutter/material.dart';

import 'siri_wave.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: const SiriWave(),
        ),
      ),
    ),
  );
}
