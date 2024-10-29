/// A Flutter library that lets you create visually stunning *Siri-style*
/// waveforms.
///
/// Currently, there are two waveform styles available:
/// - *iOS 7 Siri-style* waveform
/// - *iOS 9 Siri-style* waveform
///
/// Here's a basic example demonstrating how to create an *iOS 7 Siri-style*
/// waveform:
///
/// ```dart
/// import 'package:siri_wave/siri_wave.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return SiriWaveform.ios7();
///   }
/// }
/// ```
///
/// You can customize the waveform by passing a `controller` and/or `options`:
///
/// ```dart
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final controller = IOS7SiriWaveController(
///       amplitude: 0.5,
///       color: Colors.red,
///       frequency: 4,
///       speed: 0.15,
///     );
///     return SiriWaveform.ios7(
///       controller: controller,
///       options: IOS7SiriWaveformOptions(
///         height: 180,
///         width: 360,
///       ),
///     );
///   }
/// }
/// ```
///
/// You can also change the properties of the waveform later:
///
/// ```dart
///   controller.amplitude = 0.3;
///   controller.color = Colors.white;
/// ```
///
/// Here's a basic example demonstrating how to create an *iOS 9 Siri-style*
/// waveform:
///
/// ```dart
/// import 'package:siri_wave/siri_wave.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return SiriWaveform.ios9();
///   }
/// }
/// ```
///
/// As with the *iOS 7 Siri-style* waveform, you can customize the waveform by
/// passing a `controller` and/or `options`:
///
/// ```dart
/// import 'package:siri_wave/siri_wave.dart';
///
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final controller = IOS9SiriWaveController(
///       amplitude: 0.5,
///       speed: 0.15,
///     );
///     return SiriWaveform.ios9(
///       controller: controller,
///       options: IOS9SiriWaveformOptions(
///         height: 180,
///         width: 360,
///         showSupportBar: false,
///       ),
///     );
///   }
/// }
/// ```
library;

export 'src/ios_7/ios_7_siri_waveform.dart';
export 'src/ios_7/ios_7_siri_waveform_painter.dart';
export 'src/ios_9/ios_9_siri_waveform.dart';
export 'src/ios_9/ios_9_siri_waveform_painter.dart';
export 'src/ios_9/support_bar_painter.dart';
export 'src/models/siri_waveform_controller.dart';
export 'src/models/siri_waveform_options.dart';
export 'src/models/siri_waveform_style.dart';
export 'src/siri_waveform.dart';
