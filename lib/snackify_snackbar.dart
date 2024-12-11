import 'package:flutter/material.dart';
import 'package:snackify/enums/snack_enums.dart';

/// Builds a customizable snackbar widget.
///
/// This method provides the visual representation of a snackbar, including
/// customizable icons, text, and actions. It supports animations, gradients,
/// shadows, and other UI configurations. The snackbar also has dismissible
/// functionality for swiping away.
///
/// ### Parameters:
///
/// - **context**: The [BuildContext] of the current widget tree.
/// - **title**: A [Text] widget representing the title or main message of the snackbar.
/// - **subtitle**: A [Text] widget for the subtitle or additional details in the snackbar.
/// - **snackType**: Specifies the type of snackbar using the [SnackType] enum, which determines its appearance.
/// - **speakOnShow**: A [bool] to indicate whether the snackbar's content should be spoken (for accessibility purposes).
/// - **backgroundColor**: The background color of the snackbar container.
/// - **iconColor**: The color of the icon displayed in the snackbar.
/// - **icon**: An [IconData] representing the icon to display in the snackbar.
/// - **elevation**: The elevation of the snackbar container. Defaults to `null` if not specified.
/// - **margin**: The margin around the snackbar container. Defaults to `8.0` pixels if not specified.
/// - **borderRadius**: The border radius for rounding the corners of the snackbar container. Defaults to `8.0` if not specified.
/// - **animation**: The [Animation] object to control the fade and slide transitions of the snackbar.
/// - **actionWidget**: An optional widget displayed on the trailing end of the snackbar. Typically used for action buttons.
/// - **backgroundGradient**: An optional [Gradient] to apply to the snackbar's background. If set, overrides `backgroundColor`.
/// - **snackShadow**: A list of [BoxShadow] objects to apply shadow effects to the snackbar container.
/// - **onClose**: A callback function that is triggered when the close button is pressed.
/// - **onDismissed**: A callback function triggered when the snackbar is dismissed by a swipe. Provides the [DismissDirection].
/// - **position**: Specifies the position of the snackbar, either [SnackPosition.top] or [SnackPosition.bottom].
///
/// ### Animations:
/// The snackbar supports slide and fade animations controlled by the `animation` parameter.
/// Depending on the `position`, the snackbar slides in from the top or bottom of the screen.
///
/// ### Usage:
/// ```dart
/// buildSnackbar(
///   context: context,
///   title: Text('Success!'),
///   subtitle: Text('Your changes have been saved.'),
///   snackType: SnackType.success,
///   backgroundColor: Colors.green,
///   iconColor: Colors.white,
///   icon: Icons.check_circle,
///   animation: animationController,
///   onClose: () => print('Snackbar closed'),
///   onDismissed: (direction) => print('Snackbar dismissed'),
///   position: SnackPosition.bottom,
/// );
/// ```
///
/// ### Returns:
/// A [Widget] representing the snackbar, styled and animated based on the provided parameters.
Widget buildSnackbar({
  required BuildContext context,
  required Text title,
  required Text subtitle,
  required SnackType snackType,
  required bool? speakOnShow,
  required Color backgroundColor,
  required Color iconColor,
  required IconData icon,
  required double? elevation,

  /// - **margin**: The margin around the snackbar container. Defaults to `8.0` pixels if not specified.
  required EdgeInsetsGeometry? margin,
  required BorderRadiusGeometry? borderRadius,
  required Animation<double> animation,
  required Widget? actionWidget,
  required Gradient? backgroundGradient,
  required List<BoxShadow>? snackShadow,
  required VoidCallback onClose,
  required Function(DismissDirection direction)? onDismissed,
  required SnackPosition position,
}) {
  // Determine the start and end positions based on SnackPosition
  final Offset startOffset = position == SnackPosition.top
      ? const Offset(0, -1) // From the top
      : const Offset(0, 1); // From the bottom

  const Offset endOffset = Offset.zero; // Centered (visible)

  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: startOffset, // Start from off-screen
        end: endOffset, // Move to the center
      ).animate(animation),
      child: Dismissible(
        onDismissed: onDismissed,
        key: UniqueKey(),
        child: Container(
          margin: margin ?? const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: backgroundGradient,
            borderRadius: borderRadius ?? BorderRadius.circular(8.0),
            boxShadow: snackShadow,
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: iconColor,
            ),
            title: title,
            subtitle: subtitle,
            trailing: actionWidget ??
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: iconColor,
                  ),
                  onPressed: onClose,
                ),
          ),
        ),
      ),
    ),
  );
}
