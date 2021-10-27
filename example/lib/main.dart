import 'package:flutter/foundation.dart' show kIsWeb;
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
      title: 'Siri Wave Demo',
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
  final _isSelected = [false, true];

  Widget _buildSlider() {
    return SizedBox(
      width: 360,
      child: Slider(
        value: _amplitude,
        min: 0,
        max: 1,
        onChanged: (double value) {
          setState(() {
            _amplitude = value;
          });
        },
      ),
    );
  }

  Widget _buildToggleButtons() {
    return ToggleButtons(
      onPressed: (int index) {
        if (_isSelected[index]) {
          return;
        }

        setState(() {
          for (int i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = i == index;
          }
        });
      },
      isSelected: _isSelected,
      borderColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(16),
      selectedBorderColor: Theme.of(context).colorScheme.primary,
      children: const [
        Padding(padding: EdgeInsets.all(16), child: Text('iOS 7 Siri Wave')),
        Padding(padding: EdgeInsets.all(16), child: Text('iOS 9 Siri Wave')),
      ],
    );
  }

  Widget _buildDivider() {
    return SizedBox(
      width: 360,
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1,
      ),
    );
  }

  Widget _buildSiriWave() {
    return SiriWave(
      options: SiriWaveOptions(
        ios7options: IOS7Options(amplitude: _amplitude),
        ios9options: IOS9Options(amplitude: _amplitude),
      ),
      siriWaveStyle: _isSelected[0] ? SiriWaveStyle.ios7 : SiriWaveStyle.ios9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: kIsWeb,
        title: const Text('Siri Wave Demo'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Amplitude', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 10),
            _buildSlider(),
            const SizedBox(height: 10),
            Text('Style', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 30),
            _buildToggleButtons(),
            const Spacer(),
            _buildDivider(),
            _buildSiriWave(),
            _buildDivider(),
          ],
        ),
      ),
    );
  }
}
