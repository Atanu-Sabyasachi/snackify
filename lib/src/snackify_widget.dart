import 'package:flutter/material.dart';

/// A highly customizable Snackbar utility that allows you to display animated,
/// feature-rich notifications in your app.
class Snackify {
  /// Keeps track of all active [OverlayEntry] instances for managing stacked or non-stacked Snackbars.
  static final List<OverlayEntry> _activeEntries = [];

  /// Displays a fully customizable Snackbar with support for animations, actions, progress indicators, and more.
  ///
  /// ### Parameters:
  /// - [context]: The context in which the Snackbar will be displayed.
  /// - [message]: The main content of the Snackbar.
  /// - [backgroundColor]: Sets the Snackbar's background color.
  /// - [textStyle]: Customizes the text's style for the message.
  /// - [iconColor]: Sets the color of the icon.
  /// - [icon]: Adds an optional icon to the Snackbar.
  /// - [elevation]: Defines the Snackbar's elevation.
  /// - [margin]: Customizes the Snackbar's layout with margin.
  /// - [borderRadius]: Customizes the Snackbar's layout with border radius.
  /// - [duration]: Sets the display duration of the Snackbar.
  /// - [animationDuration]: Sets the animation duration of the Snackbar.
  /// - [offset]: Offset for positioning the Snackbar relative to its default position. Default is `Offset(0, 0)`.
  /// - [animationBuilder]: Custom animation defined by the user, providing an `Animation<double>` and the child Snackbar widget.
  /// - [progressIndicator]: Adds a progress indicator to the Snackbar.
  /// - [customWidget]: Allows the user to replace the default content with a fully custom widget.
  /// - [stackSnackbars]: Determines whether multiple Snackbars can stack on top of each other.
  /// - [persistent]: Keeps the Snackbar on the screen indefinitely until manually removed.
  /// - [backgroundGradient]: Sets a gradient background for the Snackbar.
  /// - [position]: Sets the Snackbar's position (top or bottom of the screen).
  /// - [delay]: Adds a delay before showing the Snackbar.
  /// - [useTheme]: If `true`, applies the theme's Snackbar styling.
  ///
  /// ### Example:
  /// ```dart
  /// Snackify.show(
  ///   context: context,
  ///   message: "Custom animated Snackbar!",
  ///   icon: Icons.check_circle,
  ///   backgroundColor: Colors.blueAccent,
  /// );
  /// ```
  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? iconColor,
    IconData? icon,
    double? elevation,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    Duration? duration,
    Duration? animationDuration,
    Offset offset = const Offset(0, 0),
    Widget Function(
            BuildContext context, Animation<double> animation, Widget child)?
        animationBuilder,
    Widget? progressIndicator,
    Widget? customWidget,
    bool stackSnackbars = false,
    bool persistent = false,
    Gradient? backgroundGradient,
    SnackifyPosition position = SnackifyPosition.bottom,
    Duration? delay,
    bool useTheme = false,
  }) {
    final OverlayState overlayState = Overlay.of(context);

    // If stacking is disabled, remove all active entries
    if (!stackSnackbars) {
      _removeAllActiveEntries();
    }

    // Create animation controller
    final animationController = AnimationController(
      vsync: overlayState,
      duration: animationDuration ?? const Duration(milliseconds: 800),
    );

    // Build the overlay entry
    final overlayEntry = OverlayEntry(
      builder: (context) {
        final animation = CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        );

        // Default animation fallback: Slide + Fade
        final defaultAnimationBuilder = animationBuilder ??
            (BuildContext context, Animation<double> animation, Widget child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: position == SnackifyPosition.top
                        ? const Offset(0, -1)
                        : const Offset(0, 1), // Start from top or bottom
                    end: Offset.zero, // Move to final position
                  ).animate(animation),
                  child: child,
                ),
              );
            };

        // Background style (solid color or gradient)
        final background = backgroundGradient != null
            ? BoxDecoration(
                gradient: backgroundGradient,
                borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              )
            : BoxDecoration(
                color: backgroundColor ??
                    (useTheme
                        ? Theme.of(context).snackBarTheme.backgroundColor
                        : Colors.black),
                borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              );

        return Positioned(
          top: position == SnackifyPosition.top ? offset.dy + 16.0 : null,
          bottom: position == SnackifyPosition.bottom ? offset.dy + 16.0 : null,
          left: offset.dx + 16.0,
          right: offset.dx + 16.0,
          child: defaultAnimationBuilder(
            context,
            animation,
            Material(
              elevation: elevation ?? 8.0,
              borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              child: Container(
                decoration: background,
                padding: margin ?? const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (customWidget != null) ...[
                      customWidget,
                    ] else ...[
                      if (icon != null)
                        Icon(icon,
                            color: iconColor ?? Colors.white, size: 24.0),
                      if (icon != null) const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          message,
                          style: textStyle ??
                              (useTheme
                                  ? Theme.of(context)
                                      .snackBarTheme
                                      .contentTextStyle
                                  : const TextStyle(
                                      color: Colors.white, fontSize: 16.0)),
                        ),
                      ),
                      if (progressIndicator != null) ...[
                        const SizedBox(width: 16.0),
                        progressIndicator,
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    // Add the overlay entry
    if (delay != null) {
      Future.delayed(delay, () {
        _insertOverlayEntry(overlayState, overlayEntry, animationController);
      });
    } else {
      _insertOverlayEntry(overlayState, overlayEntry, animationController);
    }

    // Auto-remove the Snackbar after the duration if not persistent
    if (!persistent) {
      Future.delayed(duration ?? const Duration(seconds: 3), () {
        animationController.reverse().then((_) {
          _removeOverlayEntry(overlayEntry);
        });
      });
    }
  }

  /// Inserts an [OverlayEntry] into the active list and starts its animation.
  static void _insertOverlayEntry(
    OverlayState overlayState,
    OverlayEntry overlayEntry,
    AnimationController animationController,
  ) {
    overlayState.insert(overlayEntry);
    _activeEntries.add(overlayEntry);
    animationController.forward();
  }

  /// Removes a specific [OverlayEntry] from the active list and the screen.
  static void _removeOverlayEntry(OverlayEntry overlayEntry) {
    overlayEntry.remove();
    _activeEntries.remove(overlayEntry);
  }

  /// Removes all active [OverlayEntry] objects.
  static void _removeAllActiveEntries() {
    for (var entry in _activeEntries) {
      entry.remove();
    }
    _activeEntries.clear();
  }
}

/// Defines a position for the Snackbar (top or bottom of the screen).
enum SnackifyPosition { top, bottom }

/// Represents an action that can be added to the Snackbar.
class SnackifyAction {
  /// Constructor for creating a [SnackifyAction].
  SnackifyAction({
    required this.label,
    required this.onPressed,
    this.labelStyle,
  });

  /// The label displayed on the action button.
  final String label;

  /// Style the label displayed on the action button.
  final TextStyle? labelStyle;

  /// The callback executed when the action button is pressed.
  final VoidCallback onPressed;
}
