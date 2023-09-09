[![ci][ci_badge]][ci_link]
[![Package: siri_wave][package_badge]][package_link]
[![Publisher: halildurmus.dev][publisher_badge]][publisher_link]
[![Language: Dart][language_badge]][language_link]
[![Platform: Flutter][platform_badge]][platform_link]
[![License: BSD-3-Clause][license_badge]][license_link]

Create visually stunning waveforms similar to those found in *Siri*.
It was inspired from the [siriwave][siriwave_link] library.

## Demo

Check out the live demo [here][demo_link].

## iOS 7 Siri-style waveform

[![iOS 7 Siri-style waveform][ios_7_gif_link]][demo_link]

## iOS 9 Siri-style waveform

[![iOS 9 Siri-style waveform][ios_9_gif_link]][demo_link]

## Usage

### iOS 7 Siri-style waveform

To create an *iOS 7 Siri-style* waveform, use the `SiriWaveform.ios7()`
constructor:

```dart
import 'package:siri_wave/siri_wave.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return SiriWaveform.ios7();
  }
}
```

You can customize the waveform by passing a `controller` and/or `options`:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = IOS7SiriWaveformController(
      amplitude: 0.5,
      color: Colors.red,
      frequency: 4,
      speed: 0.15,
    );
    return SiriWaveform.ios7(
      controller: controller,
      options: IOS7SiriWaveformOptions(
        height: 180,
        width: 360,
      ),
    );
  }
}
```

You can also change the properties of the waveform later:

```dart
  controller.amplitude = 0.3;
  controller.color = Colors.white;
```

### iOS 9 Siri-style waveform

To create an *iOS 9 Siri-style* waveform, use the `SiriWaveform.ios9()`
constructor:

```dart
import 'package:siri_wave/siri_wave.dart';

class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return SiriWaveform.ios9();
  }
}
```

As with the *iOS 7 Siri-style* waveform, you can customize the waveform by
passing a `controller` and/or `options`:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = IOS9SiriWaveformController(
      amplitude: 0.5,
      speed: 0.15,
    );
    return SiriWaveform.ios9(
      controller: controller,
      options: IOS9SiriWaveformOptions(
        height: 180,
        width: 360,
      ),
    );
  }
}
```

For a complete sample application, please checkout the [example][example_link].

To learn more, see the [API Documentation][api_documentation_link].

## 🤝 Contributing

Contributions, issues and feature requests are welcome.
Feel free to check the [issue tracker][issue_tracker_link] if you want to
contribute.

[api_documentation_link]: https://pub.dev/documentation/siri_wave/latest/
[ci_badge]: https://img.shields.io/cirrus/github/halildurmus/siri_wave
[ci_link]: https://cirrus-ci.com/halildurmus/siri_wave
[demo_link]: https://halildurmus.github.io/siri_wave
[example_link]: https://github.com/halildurmus/siri_wave/blob/main/example/lib/main.dart
[ios_7_gif_link]: https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_7.gif
[ios_9_gif_link]: https://raw.githubusercontent.com/halildurmus/siri_wave/main/gifs/ios_9.gif
[issue_tracker_link]: https://github.com/halildurmus/siri_wave/issues
[language_badge]: https://img.shields.io/badge/language-Dart-blue.svg
[language_link]: https://dart.dev
[license_badge]: https://img.shields.io/github/license/halildurmus/siri_wave?color=blue
[license_link]: https://opensource.org/licenses/BSD-3-Clause
[package_badge]: https://img.shields.io/pub/v/siri_wave.svg
[package_link]: https://pub.dev/packages/siri_wave
[platform_badge]: https://img.shields.io/badge/platform-Flutter-02569B?logo=flutter
[platform_link]: https://flutter.dev
[publisher_badge]: https://img.shields.io/pub/publisher/siri_wave.svg
[publisher_link]: https://pub.dev/publishers/halildurmus.dev
[siriwave_link]: https://github.com/kopiro/siriwave
