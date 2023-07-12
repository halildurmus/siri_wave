import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:siri_wave/siri_wave.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.amber,
        switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.amber),
            trackColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.amber.shade300;
              }
              return Colors.grey.withOpacity(.5);
            })),
      ),
      themeMode: ThemeMode.dark,
      title: 'siri_wave Demo',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _amplitude = 1.0;
  var _frequency = 6.0;
  var _showSupportBar = true;
  var _speed = .2;
  final _isSelected = [false, true];
  final _controller = SiriWaveController();
  var _currentColor = Colors.white;

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
          onChanged: (value) {
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
          onChanged: (value) {
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
          onChanged: (value) {
            _controller.setSpeed(value);
            _speed = value;
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildShowSupportBarSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Switch(
        value: _showSupportBar,
        onChanged: (value) {
          _showSupportBar = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildShowSupportBarSection() {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
      child: _isSelected[1]
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show support bar',
                    style: Theme.of(context).textTheme.titleMedium),
                _buildShowSupportBarSwitch(),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildFrequencySection() {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 400),
      child: _isSelected[0]
          ? Column(
              children: [
                Text('Frequency',
                    style: Theme.of(context).textTheme.titleLarge),
                _buildFrequencySlider(),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildWaveColorSection() {
    void showColorPickerDialog() async {
      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _currentColor,
                onColorChanged: _changeColor,
                pickerAreaHeightPercent: .7,
                displayThumbColor: true,
                paletteType: PaletteType.hsl,
                pickerAreaBorderRadius: BorderRadius.circular(8),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ElevatedButton(
                    onPressed: showColorPickerDialog,
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
      onPressed: (index) {
        if (_isSelected[index]) return;
        for (var i = 0; i < _isSelected.length; i++) {
          _isSelected[i] = i == index;
        }
        setState(() {});
      },
      borderColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(16),
      isSelected: _isSelected,
      selectedBorderColor: Theme.of(context).colorScheme.primary,
      children: const [
        Padding(padding: EdgeInsets.all(16), child: Text('iOS 7 Style')),
        Padding(padding: EdgeInsets.all(16), child: Text('iOS 9 Style')),
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

  Widget _buildWaveForm() {
    return Column(
      children: [
        _buildDivider(),
        SiriWave(
          controller: _controller,
          options: SiriWaveOptions(
            height: kIsWeb ? 300 : 180,
            showSupportBar: _showSupportBar,
            width: kIsWeb ? 600 : 360,
          ),
          style: _isSelected[0] ? SiriWaveStyle.ios_7 : SiriWaveStyle.ios_9,
        ),
        _buildDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: kIsWeb,
        title: const Text('siri_wave Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text('Amplitude', style: Theme.of(context).textTheme.titleLarge),
            _buildAmplitudeSlider(),
            Text('Speed', style: Theme.of(context).textTheme.titleLarge),
            _buildSpeedSlider(),
            _buildShowSupportBarSection(),
            _buildFrequencySection(),
            _buildWaveColorSection(),
            Text('Style', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 15),
            _buildToggleButtons(),
            const Spacer(),
            _buildWaveForm(),
          ],
        ),
      ),
    );
  }
}
