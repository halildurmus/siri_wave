# SiriWave

[![pub package](https://img.shields.io/pub/v/siri_wave.svg?style=for-the-badge)](https://pub.dev/packages/siri_wave)
[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter&style=for-the-badge)](https://flutter.dev)
![GitHub top language](https://img.shields.io/github/languages/top/halildurmus/hotdeals-app?style=for-the-badge)
[![CirrusCI](https://img.shields.io/cirrus/github/halildurmus/siri_wave?style=for-the-badge)](https://cirrus-ci.com/halildurmus/siri_wave)
[![CodeFactor](https://www.codefactor.io/repository/github/halildurmus/siri_wave/badge?style=for-the-badge)](https://www.codefactor.io/repository/github/halildurmus/siri_wave)
![Visits](https://badges.pufler.dev/visits/halildurmus/siri_wave?style=for-the-badge)

> A Flutter package to create beautiful waveforms like in *Siri*. It was inspired from the [siriwave](https://github.com/kopiro/siriwave) library.

## Demo

Check out the live demo [here](https://halildurmus.github.io/siri_wave).

## iOS 7 style

[![iOS 7](https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_7.gif)](https://halildurmus.github.io/siri_wave)

## iOS 9 style

[![iOS 9](https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_9.gif)](https://halildurmus.github.io/siri_wave)

## Getting Started

### Requirements
- `Dart >= 2.14.0`
- `Flutter >= 2.0.0`

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

To be able to change the amplitude and speed of the waveform, create a `SiriWaveController` and pass it to the `SiriWave` widget:

```dart
// You can change the default `amplitude` and `speed values` while creating the controller.
final controller = SiriWaveController();

SiriWave(controller: controller);
```

And then call `setAmplitude` or `setSpeed` methods in the controller.

```dart
controller.setAmplitude(0.8);
controller.setSpeed(0.1);
```

See the [example](https://github.com/halildurmus/siri_wave/blob/main/example/lib/main.dart) directory for a complete sample app.

## SiriWave

| Parameter    | Type                | Description                               | Default                 |
| ------------ | ------------------- | ----------------------------------------- | ----------------------- |
| `controller` | SiriWaveController  | The controller of the SiriWave.           | SiriWaveController()    |
| `options`    | SiriWaveOptions     | The configuration of the SiriWave.        | SiriWaveOptions()       |
| `style`      | SiriWaveStyle       | The wave style of the SiriWave.           | SiriWaveStyle.ios_9     |


## SiriWaveController

| Parameter    | Type     | Description                       | Default |
| ------------ | -------- | --------------------------------- | ------- |
| `amplitude`  | double   | The amplitude of the waveform.    | 1.0     |
| `speed`      | double   | The speed of the waveform.        | 0.2     |

| Function                      | Description                                                                |
| ----------------------------- | -------------------------------------------------------------------------- |
| `setAmplitude(double value)`  | Sets the amplitude of the waveform. The value must be in the [0,1] range.  |
| `setSpeed(double value)`      | Sets the speed of the waveform. The value must be in the [0,1] range       |

## SiriWaveOptions

| Parameter          | Type     | Description                              | Default       |
| ------------------ | -------- | ---------------------------------------- | ------------- |
| `backgroundColor`  | Color    | The background color of the waveform.    | Colors.black  |
| `height`           | double   | The height of the waveform.              | 180           |
| `width`            | double   | The width of the waveform.               | 360           |

## 🤝 Contributing

Contributions, issues and feature requests are welcome.
Feel free to check [issues page](https://github.com/halildurmus/siri_wave/issues) if you want to contribute.
