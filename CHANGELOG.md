# Changelog

All notable changes to this project will be documented in this file.

## [2.2.0] - 2024-11-16

### 🚀 Features

- Enable customization of iOS 9 Siri-style waveform colors ([#30](https://github.com/halildurmus/siri_wave/issues/30))

[2.2.0]: https://github.com/halildurmus/siri_wave/compare/v2.1.0..v2.2.0

## [2.1.0] - 2024-10-29

- Bump minimum required Dart version to `3.5.0`.

## 2.0.0+1

- Fixed the API Documentation link in README.

## 2.0.0

### Major Changes

- **BREAKING**: Renamed the `SiriWave` widget to `SiriWaveform`.

  `SiriWaveform` widget no longer has a default constructor. Instead, it
  provides two factory constructors:
  - `SiriWaveform.ios7()`: Creates an *iOS 7 Siri-style* waveform.
  - `SiriWaveform.ios9()`: Creates an *iOS 9 Siri-style* waveform.

- **BREAKING**: Renamed the `SiriWaveController` class to
  `SiriWaveformController`.

  `SiriWaveformController` is now a `sealed` class and includes two concrete
  subclasses:
  - `IOS7SiriWaveformController`: For managing *iOS 7 Siri-style* waveforms.
  - `IOS9SiriWaveformController`: For managing *iOS 9 Siri-style* waveforms.

  The controller classes no longer have methods to change the properties of the
  waveform (e.g., `controller.setAmplitude(0.2);`). Instead, you can directly
  modify the properties of the controller (e.g., `controller.amplitude = 0.2;`).

- **BREAKING**: Renamed the `SiriWaveOptions` class to `SiriWaveformOptions`.

  `SiriWaveformOptions` is now a `sealed` class and includes two concrete
  subclasses:
  - `IOS7SiriWaveformOptions`: Options for *iOS 7 Siri-style* waveforms.
  - `IOS9SiriWaveformOptions`: Options for *iOS 9 Siri-style* waveforms.

- **BREAKING**: Renamed the `SiriWaveStyle` enum to `SiriWaveformStyle`.

### Other Changes

- Refactored the example app.
- Improved documentation.
- Changed the library license to the `BSD 3-Clause License`.

## 1.0.2

- Exposed internally used widgets and custom painters.
- Improved code quality.
- Improved documentation.

## 1.0.1

- Improved code quality.

## 1.0.0

- **BREAKING**: Requires Dart `3.0.0` or later.
- **BREAKING**: Requires Flutter `3.7.0` or later.
- **BREAKING**: Removed the previously deprecated `backgroundColor` property
  from `SiriWaveOptions`.

## 0.3.0

- `SiriWave`'s background is now transparent -- which should now be visible in
  light backgrounds.
- `SiriWaveOptions`' `backgroundColor` property is deprecated, has no effect,
  and will be removed in a future version.
- Added `showSupportBar` property to `SiriWaveOptions` to show/hide the support
  bar on iOS 9 style waveform. By default, the support bar is shown.
- Improved code quality.

## 0.2.2

- Applied more lints to source code.
- Improved code quality.

## 0.2.1

- No changes.

## 0.2.0

- Updated minimum Dart version to `2.17` and Flutter version to `3.0.0`.
- Updated the example app.

## 0.1.1

- Added support to change the `color` and `frequency` of the iOS 7 style
  waveform.

## 0.1.0

- Added support to change the `speed` of the waveform.
- Removed `IOS7Options` and `IOS9Options` classes.
- Added `SiriWaveController` to control the `amplitude` and `speed` of the
  waveform.
- Used interpolation to smoothly change the `amplitude` and `speed` of the
  waveform.
- Renamed `siriWaveStyle` parameter to `style`.

## 0.0.1+1

- Fixed formatting issues
- Updated README.md
- Updated pubspec.yaml

## 0.0.1

- Initial release 🎉

[2.1.0]: https://github.com/halildurmus/siri_wave/compare/v2.0.0+1...v2.1.0
