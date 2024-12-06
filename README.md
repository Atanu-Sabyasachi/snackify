# Snackify

A customizable and fancy `SnackBar` widget for Flutter that provides an easy way to display SnackBars with advanced customization options, such as background color, text style, icon support, margin, and more.

![Snackify Image](assets/images/snackify_image.jpg)

## Features

- **Customizable SnackBar**: Fully customizable with options for background color, text style, icon, actions, and more.
- **Icon Support**: Add an optional icon to the Snackbar with customizable color and size.
- **Custom Duration**: Set the display duration of the Snackbar.
- **Elevation & Shape**: Control the elevation and shape (with border radius) of the Snackbar.
- **Floating Snackbar**: Floating Snackbar behavior with customizable margins and padding.
- **Dismissal Options**: Dismiss the Snackbar by tapping or swiping.
- **Stacked SnackBars**: Option to stack multiple SnackBars or replace the existing one.
- **Persistent SnackBar**: Option to keep the Snackbar visible until manually dismissed.
- **Custom Animations**: Supports custom animations for Snackbar entrance and exit.
- **Custom Actions**: Add actions (buttons) to the Snackbar, like "Undo".

## License

Snackify is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Installation

To use `Snackify` in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  snackify: ^1.0.0

Then, to use Snackify in your Dart file, import it as follows:

import 'package:snackify/snackify.dart';