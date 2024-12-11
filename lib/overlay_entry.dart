import 'package:flutter/material.dart';
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/snackify_snackbar.dart';

/// Creates an [OverlayEntry] for displaying a snackbar in the application.
///
/// This helper method builds a snackbar widget wrapped in an [OverlayEntry].
/// It manages the snackbar's animation, position, and dismissal behavior.
///
/// ### Parameters:
///
/// - **context**: The [BuildContext] of the current widget tree.
/// - **title**: A [Text] widget for the main message or title of the snackbar.
/// - **subtitle**: A [Text] widget for additional details or a description in the snackbar.
/// - **snackType**: Specifies the type of snackbar using the [SnackType] enum (e.g., success, error, info).
/// - **backgroundColor**: The background color of the snackbar widget.
/// - **iconColor**: The color of the icon displayed in the snackbar.
/// - **icon**: An [IconData] representing the icon to display in the snackbar.
/// - **speakOnShow**: A [bool] indicating if the snackbar content should be spoken aloud for accessibility purposes.
/// - **elevation**: The elevation of the snackbar widget, adding a shadow effect. Defaults to `null` if not specified.
/// - **margin**: The margin around the snackbar widget. Defaults to `16.0` pixels if not provided.
/// - **borderRadius**: The border radius for rounding the corners of the snackbar container.
/// - **offset**: The [Offset] specifying the snackbar's position in the overlay (typically the x and y offsets).
/// - **animationController**: The [AnimationController] for managing the snackbar's animation lifecycle.
/// - **backgroundGradient**: An optional [Gradient] for styling the background. Overrides `backgroundColor` if set.
/// - **position**: The position of the snackbar in the overlay ([SnackPosition.top] or [SnackPosition.bottom]).
/// - **snackShadow**: A list of [BoxShadow] objects for shadow effects on the snackbar.
/// - **actionWidget**: An optional widget (e.g., a button) displayed on the trailing end of the snackbar.
/// - **onClose**: A callback invoked when the snackbar's close button is pressed.
/// - **onDismissed**: A callback invoked when the snackbar is dismissed via a swipe gesture. Provides the [DismissDirection].
///
/// ### Returns:
/// An [OverlayEntry] containing the snackbar widget with all its configurations.
///
/// ### Animations:
/// - The snackbar utilizes a [CurvedAnimation] with the `easeOutBack` curve for smooth entry and exit.
/// - The `animationController` is used to synchronize the fade and slide transitions.
///
/// ### Example Usage:
/// ```dart
/// final overlayEntry = buildOverlayEntry(
///   context: context,
///   title: Text('Success!'),
///   subtitle: Text('Your changes were saved.'),
///   snackType: SnackType.success,
///   backgroundColor: Colors.green,
///   iconColor: Colors.white,
///   icon: Icons.check_circle,
///   speakOnShow: false,
///   animationController: animationController,
///   position: SnackPosition.bottom,
///   offset: Offset(0, 16.0),
///   onClose: () => print('Snackbar closed'),
///   onDismissed: (direction) => print('Snackbar dismissed'),
/// );
/// Overlay.of(context)?.insert(overlayEntry);
/// ```
OverlayEntry buildOverlayEntry({
  required BuildContext context,
  required Text title,
  required Text subtitle,
  required SnackType snackType,
  required Color backgroundColor,
  required Color iconColor,
  required IconData icon,
  required bool speakOnShow,
  required double? elevation,
  required EdgeInsetsGeometry? margin,
  required BorderRadiusGeometry? borderRadius,
  required Offset offset,
  required AnimationController animationController,
  required Gradient? backgroundGradient,
  required SnackPosition position,
  required List<BoxShadow>? snackShadow,
  required Widget? actionWidget,
  required VoidCallback onClose,
  required Function(DismissDirection direction)? onDismissed,
}) {
  return OverlayEntry(
    builder: (context) {
      final animation = CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      );

      return Positioned(
        top: position == SnackPosition.top ? offset.dy + 16.0 : null,
        bottom: position == SnackPosition.bottom ? offset.dy + 16.0 : null,
        left: offset.dx,
        right: offset.dx,
        child: Material(
          color: Colors.transparent,
          child: buildSnackbar(
            context: context,
            title: title,
            subtitle: subtitle,
            snackType: snackType,
            speakOnShow: speakOnShow,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            icon: icon,
            elevation: elevation,
            margin: margin,
            borderRadius: borderRadius,
            animation: animation,
            actionWidget: actionWidget,
            backgroundGradient: backgroundGradient,
            snackShadow: snackShadow,
            onClose: onClose,
            onDismissed: onDismissed,
            position: position,
          ),
        ),
      );
    },
  );
}
