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
You can use `options` and `siriWaveStyle` parameters to customize the `SiriWave`.

See the [example](https://github.com/halildurmus/siri_wave/blob/main/example/lib/main.dart) directory for a complete sample app.

## SiriWave

| Parameter              | Type               | Description                                                            | Default    | Required |
| ----------------- | ------------------ | ---------------------------------------------------------------------- | ---------- | -------- |
| `options`       | SiriWaveOptions         | The configuration of the SiriWave.           | SiriWaveOptions()       | no      |
| `style`       | SiriWaveStyle        | The wave style of the SiriWave.           | SiriWaveStyle.ios_9       | no      |

## SiriWaveOptions

| Parameter               | Type               | Description                                                            | Default    | Required |
| ----------------- | ------------------ | ---------------------------------------------------------------------- | ---------- | -------- |
| `backgroundColor`       | Color         | Background color of the waveform.          | Colors.black       | no      |
| `height`           | double      | The height of the waveform.                                                 | 180      | no       |
| `ios7Options`           | IOS7Options             | The configuration of the iOS 7 Siri wave style.                    | IOS7Options() | no       |
| `ios9Options`           | IOS9Options             | The configuration of the iOS 9 Siri wave style.                                            | IOS9Options()        | no       |
| `width`       | double             | Width of the waveform.                              | 360          | no       |

## IOS7Options

| Parameter              | Type               | Description                                                            | Default    | Required |
| ----------------- | ------------------ | ---------------------------------------------------------------------- | ---------- | -------- |
| `amplitude`       | double         | Amplitude of the waveform. Must be in [0,1] range.           | 1       | no      |

## IOS9Options

| Parameter               | Type               | Description                                                            | Default    | Required |
| ----------------- | ------------------ | ---------------------------------------------------------------------- | ---------- | -------- |
| `amplitude`       | double         | Amplitude of the waveform. Must be in [0,1] range.         | 1       | no      |

## 🤝 Contributing

Contributions, issues and feature requests are welcome.
Feel free to check [issues page](https://github.com/halildurmus/siri_wave/issues) if you want to contribute.