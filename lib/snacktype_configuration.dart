import 'package:flutter/material.dart';

/// Configuration for the appearance and behavior of different snackbars.
///
/// This class is used to define the properties for each snackbar type such as
/// background color, icon, text style, margin, and more. The properties allow
/// full customization of how a snackbar looks and behaves.
class SnackTypeConfiguration {
  /// Creates a [SnackTypeConfiguration] with the specified properties.
  ///
  /// [backgroundColor] defines the background color of the snackbar.
  /// [icon] specifies the icon to be shown on the snackbar.
  /// [iconColor] defines the color of the icon.
  /// [title] is the main title displayed in the snackbar.
  /// [subtitle] is the secondary text shown below the title.
  /// [textStyle] specifies the style for the text.
  /// [elevation] adds shadow depth to the snackbar.
  /// [margin] defines the space around the snackbar.
  /// [borderRadius] is the rounding of the snackbar's corners.
  SnackTypeConfiguration({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.textStyle,
    required this.elevation,
    required this.margin,
    required this.borderRadius,
  });

  /// The background color of the snackbar.
  ///
  /// This determines the overall color of the snackbar's background.
  final Color backgroundColor;

  /// The border radius of the snackbar.
  ///
  /// This defines how rounded the corners of the snackbar will be.
  final BorderRadiusGeometry borderRadius;

  /// The elevation of the snackbar.
  ///
  /// This property determines the shadow and depth of the snackbar,
  /// making it appear raised or flat.
  final double elevation;

  /// The icon shown in the snackbar.
  ///
  /// This icon represents the type of message (e.g., success, error, etc.)
  final IconData icon;

  /// The color of the icon in the snackbar.
  ///
  /// This property allows customization of the icon's color to match
  /// the snackbar's design and type.
  final Color iconColor;

  /// The margin around the snackbar.
  ///
  /// This property defines the space between the snackbar and the edges
  /// of the screen or other widgets.
  final EdgeInsetsGeometry margin;

  /// The style for the text displayed in the snackbar.
  ///
  /// This can include font size, weight, color, and other text styling.
  final TextStyle textStyle;

  /// The title text displayed in the snackbar.
  ///
  /// This is the main message shown in the snackbar.
  final Text title;

  /// The subtitle text displayed in the snackbar.
  ///
  /// This is the secondary message shown below the title, typically used
  /// for additional details or context.
  final Text subtitle;
}
