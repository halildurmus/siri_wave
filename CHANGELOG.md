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
