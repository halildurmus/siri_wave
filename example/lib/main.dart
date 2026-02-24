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
    title: 'package:siri_wave Demo',
    theme: ThemeData.dark().copyWith(
      colorScheme: const .dark(
        primary: .new(0xFF00A8E8),
        secondary: .new(0xFF8E44AD),
        surface: .new(0xFF1A1A2E),
      ),
      scaffoldBackgroundColor: const .new(0xFF0F1419),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: .new(0xFF1A1A2E),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: .circular(16)),
        color: const .new(0xFF1A1A2E),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: const .new(0xFF00A8E8),
        inactiveTrackColor: const Color(0xFF00A8E8).withValues(alpha: 0.2),
        thumbColor: const .new(0xFF00A8E8),
        overlayColor: const Color(0xFF00A8E8).withValues(alpha: 0.2),
        trackHeight: 4,
      ),
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var amplitude = 1.0;
  Color color = Colors.white;
  var color1 = const Color(0xFF00D9FF);
  var color2 = const Color(0xFFFF006E);
  var color3 = const Color(0xFF8338EC);
  SiriWaveformController controller = IOS9SiriWaveformController();
  double frequency = 6;
  final selection = [false, true];
  var showSupportBar = true;
  var speed = .2;

  SiriWaveformStyle get style => selection[0] ? .ios_7 : .ios_9;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 1000;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'package:siri_wave Demo',
          style: .new(fontWeight: .bold, letterSpacing: 1.2),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),
      ),
      body: isLargeScreen ? _buildWideLayout() : _buildNarrowLayout(),
    );
  }

  Widget _buildWideLayout() => Row(
    children: [
      // Left Sidebar - Controls
      SizedBox(
        width: 380,
        child: SingleChildScrollView(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              _buildStyleToggle(),
              const SizedBox(height: 16),
              _buildControlsSection(),
            ],
          ),
        ),
      ),

      // Vertical Divider
      Container(width: 1, color: Colors.white.withValues(alpha: 0.1)),

      // Right Side - Waveform Display
      Expanded(
        child: Center(
          child: Padding(
            padding: const .all(40),
            child: _buildWaveformSection(),
          ),
        ),
      ),
    ],
  );

  Widget _buildNarrowLayout() => SingleChildScrollView(
    padding: const .all(16),
    child: Column(
      children: [
        _buildWaveformSection(),
        const SizedBox(height: 16),
        _buildStyleToggle(),
        const SizedBox(height: 16),
        _buildControlsSection(),
        const SizedBox(height: 16),
      ],
    ),
  );

  Widget _buildStyleToggle() => Card(
    child: Padding(
      padding: const .all(20),
      child: Column(
        children: [
          const Text(
            'Waveform Style',
            style: .new(fontSize: 16, fontWeight: .w600, letterSpacing: 0.5),
          ),
          const SizedBox(height: 16),
          ToggleButtons(
            borderRadius: .circular(12),
            isSelected: selection,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            color: Colors.white60,
            constraints: const .new(minHeight: 48, minWidth: 120),
            onPressed: (index) {
              if (selection[index]) return;
              setState(() {
                for (var i = 0; i < selection.length; i++) {
                  selection[i] = i == index;
                }
                controller = index == 0
                    ? IOS7SiriWaveformController()
                    : IOS9SiriWaveformController();
              });
            },
            children: const [
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Text(
                  'iOS 7',
                  style: .new(fontSize: 15, fontWeight: .w600),
                ),
              ),
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Text(
                  'iOS 9',
                  style: .new(fontSize: 15, fontWeight: .w600),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _buildWaveformSection() => Card(
    elevation: 8,
    child: Container(
      constraints: const .new(maxWidth: 1200),
      decoration: BoxDecoration(
        borderRadius: .circular(16),
        gradient: const LinearGradient(
          begin: .topLeft,
          end: .bottomRight,
          colors: [.new(0xFF0A0E27), .new(0xFF1A1A2E)],
        ),
      ),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: SiriWaveformWidget(
          controller: controller,
          showSupportBar: showSupportBar,
          style: style,
        ),
      ),
    ),
  );

  Widget _buildControlsSection() => Card(
    child: Padding(
      padding: const .all(20),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          // Amplitude Control
          _buildSliderControl(
            label: 'Amplitude',
            value: amplitude,
            onChanged: (value) {
              controller.amplitude = value;
              setState(() => amplitude = value);
            },
          ),

          const SizedBox(height: 20),

          // Speed Control
          _buildSliderControl(
            label: 'Speed',
            value: speed,
            onChanged: (value) {
              controller.speed = value;
              setState(() => speed = value);
            },
          ),

          const SizedBox(height: 20),

          // Style-specific controls
          if (style == .ios_9) ...[
            // Show Support Bar Toggle
            Container(
              padding: const .all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: .circular(12),
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  const Text(
                    'Show Support Bar',
                    style: .new(fontSize: 14, fontWeight: .w600),
                  ),
                  Switch(
                    value: showSupportBar,
                    onChanged: (value) {
                      setState(() => showSupportBar = value);
                    },
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Wave Colors Section
            const Text(
              'Wave Colors',
              textAlign: .center,
              style: .new(fontSize: 16, fontWeight: .bold, letterSpacing: 0.5),
            ),

            const SizedBox(height: 16),

            // Color Pickers
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                _buildColorPicker(
                  title: 'Color 1',
                  color: color1,
                  onChanged: (value) {
                    setState(() => color1 = value);
                    (controller as IOS9SiriWaveformController).color1 = value;
                  },
                ),
                _buildColorPicker(
                  title: 'Color 2',
                  color: color2,
                  onChanged: (value) {
                    setState(() => color2 = value);
                    (controller as IOS9SiriWaveformController).color2 = value;
                  },
                ),
                _buildColorPicker(
                  title: 'Color 3',
                  color: color3,
                  onChanged: (value) {
                    setState(() => color3 = value);
                    (controller as IOS9SiriWaveformController).color3 = value;
                  },
                ),
              ],
            ),
          ] else ...[
            // iOS 7 Frequency Control
            _buildSliderControl(
              label: 'Frequency',
              value: frequency,
              min: -20,
              max: 20,
              divisions: 40,
              onChanged: (value) {
                (controller as IOS7SiriWaveformController).frequency = value
                    .round();
                setState(() => frequency = value);
              },
            ),

            const SizedBox(height: 20),

            // Wave Color
            const Text(
              'Wave Color',
              textAlign: .center,
              style: .new(fontSize: 16, fontWeight: .bold, letterSpacing: 0.5),
            ),

            const SizedBox(height: 16),

            Center(
              child: _buildColorPicker(
                title: 'Color',
                color: color,
                onChanged: (value) {
                  setState(() => color = value);
                  (controller as IOS7SiriWaveformController).color = value;
                },
              ),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _buildSliderControl({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
  }) => Column(
    crossAxisAlignment: .start,
    children: [
      Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            label,
            style: const .new(
              fontSize: 14,
              fontWeight: .w600,
              letterSpacing: 0.3,
            ),
          ),
          Container(
            padding: const .symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: .circular(16),
              border: .all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              value.toStringAsFixed(2),
              style: .new(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: .bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        ),
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ),
    ],
  );

  Widget _buildColorPicker({
    required String title,
    required Color color,
    required ValueChanged<Color> onChanged,
  }) => Column(
    children: [
      Text(title, style: const .new(fontSize: 13, fontWeight: .w600)),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => _showColorPickerDialog(color, onChanged),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: .circular(12),
            border: .all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: 6,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const .new(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.palette_outlined,
            color: _getContrastColor(color),
            size: 24,
          ),
        ),
      ),
    ],
  );

  Color _getContrastColor(Color color) =>
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  Future<void> _showColorPickerDialog(
    Color currentColor,
    ValueChanged<Color> onColorChanged,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Pick a Color'),
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.8,
            displayThumbColor: true,
            paletteType: .hslWithHue,
            labelTypes: const [],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Done',
              style: .new(fontSize: 16, fontWeight: .w600),
            ),
          ),
        ],
      ),
    );
  }
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
  Widget build(BuildContext context) {
    const height = kIsWeb ? 400.0 : 250.0;
    return Padding(
      padding: const .all(20),
      child: style == .ios_7
          ? SiriWaveform.ios7(
              controller: controller as IOS7SiriWaveformController,
              options: const IOS7SiriWaveformOptions(
                height: height,
                width: .infinity,
              ),
            )
          : SiriWaveform.ios9(
              controller: controller as IOS9SiriWaveformController,
              options: IOS9SiriWaveformOptions(
                height: height,
                showSupportBar: showSupportBar,
                width: .infinity,
              ),
            ),
    );
  }
}
