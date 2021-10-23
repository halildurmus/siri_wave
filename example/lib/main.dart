import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _amplitude = 1;
  final List<bool> _isSelected = [false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amplitude',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Slider(
                value: _amplitude,
                divisions: 10,
                label: _amplitude.toStringAsFixed(1),
                min: 0,
                max: 1,
                onChanged: (double value) {
                  setState(() {
                    _amplitude = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Style',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 30),
            ToggleButtons(
              borderRadius: BorderRadius.circular(16),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('iOS 7 Siri Wave'),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('iOS 9 Siri Wave'),
                ),
              ],
              onPressed: (int index) {
                if (_isSelected[index]) {
                  return;
                }

                setState(() {
                  _amplitude = index == 0 ? .3 : 1;
                  for (int i = 0; i < _isSelected.length; i++) {
                    _isSelected[i] = i == index;
                  }
                });
              },
              isSelected: _isSelected,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 400,
              child: SiriWave(
                amplitude: _amplitude,
                siriWaveStyle:
                    _isSelected[0] ? SiriWaveStyle.ios7 : SiriWaveStyle.ios9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
