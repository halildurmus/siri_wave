import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  double _frequency = 6;
  double _speed = .2;
  final _isSelected = [false, true];
  final _controller = SiriWaveController();
  Color _currentColor = Colors.white;

  void _changeColor(Color color) {
    _currentColor = color;
    _controller.setColor(color);
  }

  Widget _buildAmplitudeSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 360,
        child: Slider(
          value: _amplitude,
          min: 0,
          max: 1,
          onChanged: (double value) {
            _controller.setAmplitude(value);
            _amplitude = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildFrequencySlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 360,
        child: Slider(
          value: _frequency,
          divisions: 40,
          min: -20,
          max: 20,
          onChanged: (double value) {
            _controller.setFrequency(value.round());
            _frequency = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildSpeedSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 360,
        child: Slider(
          value: _speed,
          min: 0,
          max: 1,
          onChanged: (double value) {
            _controller.setSpeed(value);
            _speed = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildFrequencySection() {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
      child: _isSelected[0]
          ? Column(
              children: [
                Text('Frequency', style: Theme.of(context).textTheme.headline6),
                _buildFrequencySlider(),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildWaveColorSection() {
    void _showColorPickerDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _currentColor,
                onColorChanged: _changeColor,
                pickerAreaHeightPercent: .7,
                displayThumbColor: true,
                paletteType: PaletteType.hsl,
                pickerAreaBorderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          );
        },
      );
    }

    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
      child: _isSelected[0]
          ? Column(
              children: [
                Text(
                  'Wave Color',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ElevatedButton(
                    onPressed: () => _showColorPickerDialog(),
                    child: const Text('Change color'),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildToggleButtons() {
    return ToggleButtons(
      onPressed: (int index) {
        if (_isSelected[index]) {
          return;
        }

        for (int i = 0; i < _isSelected.length; i++) {
          _isSelected[i] = i == index;
        }
        setState(() {});
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
      width: kIsWeb ? 600 : 360,
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1,
      ),
    );
  }

  Widget _buildSiriWave() {
    return Column(
      children: [
        _buildDivider(),
        SiriWave(
          controller: _controller,
          options: const SiriWaveOptions(
            height: kIsWeb ? 300 : 180,
            width: kIsWeb ? 600 : 360,
          ),
          style: _isSelected[0] ? SiriWaveStyle.ios_7 : SiriWaveStyle.ios_9,
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text('Amplitude', style: Theme.of(context).textTheme.headline6),
          _buildAmplitudeSlider(),
          Text('Speed', style: Theme.of(context).textTheme.headline6),
          _buildSpeedSlider(),
          _buildFrequencySection(),
          _buildWaveColorSection(),
          Text('Style', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 15),
          _buildToggleButtons(),
          const Spacer(),
          _buildSiriWave(),
        ],
      ),
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
      body: _buildBody(),
    );
  }
}
