import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/animation_initializer.dart';
import 'package:snackify/snacktype_configuration.dart';

/// Snackify: A customizable Snackbar alternative with enhanced flexibility.
class Snackify {
  /// A list that holds all active OverlayEntries.
  /// This helps manage active snackbars and remove them as needed.
  static final List<OverlayEntry> _activeEntries = [];

  /// Displays a customizable snackbar using an overlay.
  ///
  /// This method allows you to show a snackbar with a variety of options
  /// such as position, animation duration, background gradient, action button,
  /// and more.
  ///
  /// - [context]: The BuildContext to insert the snackbar into the overlay.
  /// - [type]: The type of the snackbar (e.g., success, error).
  /// - [title]: The title of the snackbar.
  /// - [subtitle]: The subtitle text displayed below the title.
  /// - [duration]: The duration for which the snackbar is visible.
  /// - [animationDuration]: The duration of the snackbar's entrance/exit animation.
  /// - [offset]: The offset from the top or bottom of the screen.
  /// - [persistent]: Whether the snackbar should remain visible until manually closed.
  /// - [backgroundGradient]: A gradient background for the snackbar.
  /// - [position]: The position of the snackbar (top, bottom).
  /// - [action]: An optional widget for custom action (e.g., a button).
  /// - [delay]: A delay before the snackbar is shown.
  static void show({
    /// The BuildContext where the snackbar will be displayed.
    required BuildContext context,

    /// The type of the snackbar (e.g., success, error).
    required SnackType type,

    /// The title to display in the snackbar.
    Text? title,

    /// The subtitle to display below the title in the snackbar.
    Text? subtitle,

    /// The duration for which the snackbar is visible. Defaults to 3 seconds.
    Duration? duration,

    /// The duration of the snackbar's entrance/exit animation.
    Duration? animationDuration,

    /// The offset from the top or bottom of the screen. Defaults to (0, 0).
    Offset offset = const Offset(0, 0),

    /// Whether the snackbar should remain visible until manually closed.
    bool persistent = false,

    /// A gradient background for the snackbar.
    Gradient? backgroundGradient,

    /// The position of the snackbar on the screen (top or bottom).
    SnackPosition position = SnackPosition.bottom,

    /// An optional widget for custom action (e.g., a button).
    Widget? action,

    /// A delay before the snackbar is shown.
    Duration? delay,
  }) {
    final OverlayState overlayState = Overlay.of(context);
    final purposeDetails = _getPurposeDetails(type);

    // Remove all active snackbars if stackSnackbars is false
    //if (!stackSnackbars) {
    //_removeAllActiveEntries();
    //}

    final animationController = createAnimationController(
      overlayState,
      animationDuration,
    );

    OverlayEntry? overlayEntry;

    overlayEntry = _buildOverlayEntry(
      context: context,
      title: title ?? purposeDetails.title,
      subtitle: subtitle ?? purposeDetails.subtitle,
      snackType: type,
      backgroundColor: purposeDetails.backgroundColor,
      iconColor: purposeDetails.iconColor,
      icon: purposeDetails.icon,
      elevation: purposeDetails.elevation,
      margin: purposeDetails.margin,
      borderRadius: purposeDetails.borderRadius,
      offset: offset,
      animationController: animationController,
      backgroundGradient: backgroundGradient,
      position: position,
      actionWidget: action,
      onClose: () {
        animationController.reverse().then((_) {
          if (overlayEntry != null) {
            _removeOverlayEntry(overlayEntry!);
            overlayEntry = null;
          }
        });
      },
    );

    // Show snackbar with delay if specified
    if (delay != null) {
      Future.delayed(delay, () {
        if (overlayEntry != null) {
          _insertOverlayEntry(overlayState, overlayEntry!, animationController);
          overlayEntry = null;
        }
      });
    } else {
      if (overlayEntry != null) {
        _insertOverlayEntry(overlayState, overlayEntry!, animationController);
        overlayEntry = null;
      }
    }

    // Remove the snackbar after the specified duration if persistent is false
    if (!persistent) {
      Future.delayed(duration ?? const Duration(seconds: 3), () {
        animationController.reverse().then((_) {
          if (overlayEntry != null) {
            _removeOverlayEntry(overlayEntry!);
            overlayEntry = null;
          }
        });
      });
    }
  }

  // =================== PRIVATE HELPER METHODS =================== //

  /// Builds the overlay entry for the snackbar.
  ///
  /// This method constructs the actual snackbar widget and handles animation.
  /// It also defines its appearance, position, and behavior when dismissed.
  static OverlayEntry _buildOverlayEntry({
    required BuildContext context,
    required Text title,
    required Text subtitle,
    required SnackType snackType,
    required Color backgroundColor,
    required Color iconColor,
    required IconData icon,
    required double? elevation,
    required EdgeInsetsGeometry? margin,
    required BorderRadiusGeometry? borderRadius,
    required Offset offset,
    required AnimationController animationController,
    required Gradient? backgroundGradient,
    required SnackPosition position,
    required Widget? actionWidget,
    required VoidCallback onClose,
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
            child: _buildSnackbar(
              context,
              title,
              subtitle,
              snackType,
              backgroundColor,
              iconColor,
              icon,
              elevation,
              margin,
              borderRadius,
              animation,
              actionWidget,
              backgroundGradient,
              onClose,
              position,
            ),
          ),
        );
      },
    );
  }

  /// Builds the snackbar widget.
  ///
  /// This method returns the actual UI representation of the snackbar.
  /// It includes features such as custom icons, text, and action buttons.
  static Widget _buildSnackbar(
    BuildContext context,
    Text title,
    Text subtitle,
    SnackType snackType,
    Color backgroundColor,
    Color iconColor,
    IconData icon,
    double? elevation,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    Animation<double> animation,
    Widget? actionWidget,
    Gradient? backgroundGradient,
    VoidCallback onClose,
    SnackPosition position,
  ) {
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
          key: UniqueKey(),
          child: Container(
            margin: margin ?? const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: backgroundGradient,
              borderRadius: borderRadius ?? BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                ),
              ],
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
                    icon: Icon(Icons.close, color: iconColor),
                    onPressed: onClose,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  /// Inserts the overlay entry into the screen.
  ///
  /// This method is responsible for adding the snackbar to the overlay
  /// and starting the entrance animation.
  static void _insertOverlayEntry(OverlayState overlayState,
      OverlayEntry overlayEntry, AnimationController animationController) {
    overlayState.insert(overlayEntry);
    animationController.forward();
  }

  /// Removes a given overlay entry from the screen.
  ///
  /// This method is called to remove the snackbar from the screen once it's dismissed.
  static void _removeOverlayEntry(OverlayEntry overlayEntry) {
    overlayEntry.remove();
    _activeEntries.remove(overlayEntry);
  }

  // /// Removes all active overlay entries.
  // ///
  // /// This method clears all currently active snackbars from the screen.
  // static void _removeAllActiveEntries() {
  //   for (var entry in _activeEntries) {
  //     entry.remove();
  //   }
  //   _activeEntries.clear();
  // }

  /// Gets the details of the snackbar based on its type.
  ///
  /// This method retrieves configuration options such as background color,
  /// icon, text style, etc., for the specified snackbar type.
  static SnackTypeConfiguration _getPurposeDetails(SnackType purpose) {
    switch (purpose) {
      case SnackType.success:
        return SnackTypeConfiguration(
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
          iconColor: Colors.white,
          title: Text(
            'Success!',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'This is a success message',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          textStyle: const TextStyle(color: Colors.white),
          elevation: 6.0,
          margin: const EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(10),
        );
      case SnackType.error:
        return SnackTypeConfiguration(
          backgroundColor: Colors.red,
          icon: Icons.error,
          iconColor: Colors.white,
          title: Text(
            'Error!',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'This is an error message',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          textStyle: const TextStyle(color: Colors.white),
          elevation: 6.0,
          margin: const EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(10),
        );
      case SnackType.warning:
        return SnackTypeConfiguration(
          backgroundColor: Colors.yellow[700]!,
          icon: Icons.warning,
          iconColor: Colors.white,
          title: Text(
            'Warning!',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'This is a warning message',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          textStyle: const TextStyle(color: Colors.black),
          elevation: 6.0,
          margin: const EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(10),
        );
      case SnackType.info:
        return SnackTypeConfiguration(
          backgroundColor: Colors.blue,
          icon: Icons.info,
          iconColor: Colors.white,
          title: Text(
            'Info',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'This is an info message',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          textStyle: const TextStyle(color: Colors.white),
          elevation: 6.0,
          margin: const EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(10),
        );
    }
  }
}
