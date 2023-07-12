# siri_wave

[![ci](https://img.shields.io/cirrus/github/halildurmus/siri_wave)](https://cirrus-ci.com/halildurmus/siri_wave)
[![Package: siri_wave](https://img.shields.io/pub/v/siri_wave.svg)](https://pub.dev/packages/siri_wave)
[![Publisher: halildurmus.dev](https://img.shields.io/pub/publisher/siri_wave.svg)](https://pub.dev/publishers/halildurmus.dev)
[![Language: Dart](https://img.shields.io/badge/language-Dart-blue.svg)](https://dart.dev)
[![Platform: Flutter](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/github/license/halildurmus/siri_wave?color=blue)](https://opensource.org/licenses/mit)

> Create beautiful waveforms like in *Siri*.
It was inspired from the [siriwave](https://github.com/kopiro/siriwave) library.

## Demo

Check out the live demo [here](https://halildurmus.github.io/siri_wave).

## iOS 7 style waveform

[![iOS 7 style waveform](https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_7.gif)](https://halildurmus.github.io/siri_wave)

## iOS 9 style waveform

[![iOS 9 style waveform](https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_9.gif)](https://halildurmus.github.io/siri_wave)

## Getting Started

### Requirements
- `Dart >= 3.0.0`
- `Flutter >= 3.7.0`

## Usage

Simply create a `SiriWave` widget:

```dart
import 'package:siri_wave/siri_wave.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return SiriWave();
  }
}
```

To customize the `amplitude`, `frequency`, `speed`, and `color` properties of
the waveform, create an instance of `SiriWaveController` and pass it to the
`SiriWave` widget as shown in the code snippet below:

```dart
import 'package:siri_wave/siri_wave.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    // You can customize the default values of the waveform while creating the
    // controller:
    //  final controller = SiriWaveController(
    //    amplitude: 0.5,
    //    color: Colors.red,
    //    frequency: 4,
    //    speed: 0.15,
    //  );
    final controller = SiriWaveController();
    return SiriWave(controller: controller);
  }
}
```

Afterward, you can invoke any desired method from the controller to modify the
waveform:

```dart
controller.setAmplitude(0.8);
controller.setSpeed(0.1);

// These are only available in the iOS 7 style waveform.
controller.setColor(Colors.yellow);
controller.setFrequency(4);
```

For a complete sample application, please checkout the [example](https://github.com/halildurmus/siri_wave/blob/main/example/lib/main.dart).

## SiriWave

| Parameter    | Type               | Description                        | Default              |
| ------------ | ------------------ | ---------------------------------- | -------------------- |
| `controller` | SiriWaveController | The controller of the SiriWave.    | SiriWaveController() |
| `options`    | SiriWaveOptions    | The configuration of the SiriWave. | SiriWaveOptions()    |
| `style`      | SiriWaveStyle      | The wave style of the SiriWave.    | SiriWaveStyle.ios_9  |


## SiriWaveController

| Parameter   | Type   | Description                                | Default      |
| ----------- | ------ | ------------------------------------------ | ------------ |
| `amplitude` | double | The amplitude of the waveform.             | 1.0          |
| `color`     | Color  | The color of the iOS 7 style waveform.     | Colors.white |
| `frequency` | int    | The frequency of the iOS 7 style waveform. | 6            |
| `speed`     | double | The speed of the waveform.                 | 0.2          |

| Function                     | Description                                                                              |
| ---------------------------- | ---------------------------------------------------------------------------------------- |
| `setAmplitude(double value)` | Sets the amplitude of the waveform. The value must be in the [0,1] range.                |
| `setColor(Color color)`      | Sets the color of the iOS 7 style waveform.                                              |
| `setFrequency(double value)` | Sets the frequency of the iOS 7 style waveform. The value must be in the [-20,20] range. |
| `setSpeed(double value)`     | Sets the speed of the waveform. The value must be in the [0,1] range.                    |

## SiriWaveOptions

| Parameter        | Type   | Description                                          | Default |
| ---------------- | ------ | ---------------------------------------------------- | ------- |
| `height`         | double | The height of the waveform.                          | 180     |
| `showSupportBar` | bool   | Whether to show support bar on iOS 9 style waveform. | true    |
| `width`          | double | The width of the waveform.                           | 360     |

## 🤝 Contributing

Contributions, issues and feature requests are welcome.
Feel free to check [issues page](https://github.com/halildurmus/siri_wave/issues)
if you want to contribute.
