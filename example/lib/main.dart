import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:siri_wave/siri_wave.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        title: 'siri_wave Demo',
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double amplitude = 1;
  Color color = Colors.white;
  SiriWaveformController controller = IOS9SiriWaveformController();
  double frequency = 6;
  final selection = [false, true];
  bool showSupportBar = true;
  double speed = .2;

  SiriWaveformStyle get style =>
      selection[0] ? SiriWaveformStyle.ios_7 : SiriWaveformStyle.ios_9;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: kIsWeb,
          title: const Text('siri_wave Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CustomSlider(
                onChanged: (value) {
                  controller.amplitude = value;
                  setState(() => amplitude = value);
                },
                label: 'Amplitude',
                value: amplitude,
              ),
              CustomSlider(
                onChanged: (value) {
                  controller.speed = value;
                  setState(() => speed = value);
                },
                label: 'Speed',
                value: speed,
              ),
              if (style == SiriWaveformStyle.ios_9)
                CustomSwitch(
                  onChanged: (value) {
                    setState(() => showSupportBar = value);
                  },
                  value: showSupportBar,
                )
              else ...[
                FrequencySlider(
                  onChanged: (value) {
                    (controller as IOS7SiriWaveformController).frequency =
                        value.round();
                    setState(() => frequency = value);
                  },
                  value: frequency,
                ),
                ColorPickerWidget(
                  onChanged: (value) {
                    setState(() => color = value);
                    (controller as IOS7SiriWaveformController).color = value;
                  },
                  color: color,
                ),
              ],
              WaveformStyleToggleButtons(
                onPressed: (index) {
                  if (selection[index]) return;
                  for (var i = 0; i < selection.length; i++) {
                    selection[i] = i == index;
                  }
                  controller = index == 0
                      ? IOS7SiriWaveformController()
                      : IOS9SiriWaveformController();
                  setState(() {});
                },
                selection: selection,
              ),
              const Spacer(),
              const CustomDivider(),
              SiriWaveformWidget(
                controller: controller,
                showSupportBar: showSupportBar,
                style: style,
              ),
              const CustomDivider(),
            ],
          ),
        ),
      );
}

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    required this.onChanged,
    required this.label,
    required this.value,
    super.key,
  });

  final ValueChanged<double> onChanged;

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              width: 360,
              child: Slider(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      );
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    required this.onChanged,
    required this.value,
    super.key,
  });

  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) => AnimatedSize(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show support bar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Switch(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
}

class FrequencySlider extends StatelessWidget {
  const FrequencySlider({
    required this.onChanged,
    required this.value,
    super.key,
  });

  final ValueChanged<double> onChanged;
  final double value;

  @override
  Widget build(BuildContext context) => AnimatedSize(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        child: Column(
          children: [
            Text(
              'Frequency',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                width: 360,
                child: Slider(
                  value: value,
                  divisions: 40,
                  min: -20,
                  max: 20,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      );
}

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    required this.onChanged,
    required this.color,
    super.key,
  });

  final ValueChanged<Color> onChanged;
  final Color color;

  @override
  Widget build(BuildContext context) => AnimatedSize(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        child: Column(
          children: [
            Text(
              'Color',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: color,
                          onColorChanged: onChanged,
                          pickerAreaHeightPercent: .7,
                          displayThumbColor: true,
                          paletteType: PaletteType.hsl,
                          pickerAreaBorderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Change color'),
              ),
            ),
          ],
        ),
      );
}

class WaveformStyleToggleButtons extends StatelessWidget {
  const WaveformStyleToggleButtons({
    required this.onPressed,
    required this.selection,
    super.key,
  });

  final ValueChanged<int> onPressed;
  final List<bool> selection;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text('Style', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 15),
          ToggleButtons(
            onPressed: onPressed,
            borderColor: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(16),
            isSelected: selection,
            selectedBorderColor: Theme.of(context).colorScheme.primary,
            children: const [
              Padding(padding: EdgeInsets.all(16), child: Text('iOS 7')),
              Padding(padding: EdgeInsets.all(16), child: Text('iOS 9')),
            ],
          ),
        ],
      );
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: kIsWeb ? 600 : 360,
        child: Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 1,
        ),
      );
}

class SiriWaveformWidget extends StatelessWidget {
  const SiriWaveformWidget({
    required this.controller,
    required this.style,
    this.showSupportBar = true,
    super.key,
  });

  final SiriWaveformController controller;
  final bool showSupportBar;
  final SiriWaveformStyle style;

  @override
  Widget build(BuildContext context) => style == SiriWaveformStyle.ios_7
      ? SiriWaveform.ios7(
          controller: controller as IOS7SiriWaveformController,
          options: const IOS7SiriWaveformOptions(
            height: kIsWeb ? 300 : 180,
            width: kIsWeb ? 600 : 360,
          ),
        )
      : SiriWaveform.ios9(
          controller: controller as IOS9SiriWaveformController,
          options: IOS9SiriWaveformOptions(
            height: kIsWeb ? 300 : 180,
            showSupportBar: showSupportBar,
            width: kIsWeb ? 600 : 360,
          ),
        );
}
