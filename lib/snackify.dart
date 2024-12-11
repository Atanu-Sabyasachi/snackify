// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import the TTS package
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/initializers.dart';
import 'package:snackify/overlay_entry.dart';
import 'package:snackify/snack_type_details.dart';
import 'package:snackify/snacktype_configuration.dart';
import 'package:snackify/tts_config.dart';

/// Snackify: A customizable Snack alternative with enhanced flexibility.
/// This class allows you to display snacks with customizable properties such as
/// animation, position, background gradient, text-to-speech functionality, and more.
class Snackify {
  // FlutterTts instance for Text-to-Speech functionality
  static final FlutterTts _flutterTts = FlutterTts();

  /// A list that holds all active OverlayEntries.
  /// This helps manage active snacks and remove them as needed.
  static final List<OverlayEntry> _activeEntries = [];

  /// Displays a customizable snack using an overlay.
  ///
  /// This method allows you to show a snack with a variety of options such as position,
  /// animation duration, background gradient, action button, and more.
  ///
  /// - [context]: The BuildContext to insert the snack into the overlay.
  ///
  /// - [type]: The type of the snack (e.g., success, error).
  ///
  /// - [title]: The title of the snack.
  ///
  /// - [subtitle]: The subtitle text displayed below the title.
  ///
  /// - [duration]: The duration for which the snack is visible. Defaults to 3 seconds.
  ///
  /// - [animationDuration]: The duration of the snack's entrance/exit animation.
  ///
  /// - [offset]: The offset from the top or bottom of the screen. Defaults to (0, 0).
  ///
  /// - [persistent]: Whether the snack should remain visible until manually closed.
  ///
  /// - [backgroundGradient]: A gradient background for the snack.
  ///
  /// - [position]: The position of the snack (top or bottom).
  ///
  /// - [action]: An optional widget for custom action (e.g., a button).
  ///
  /// - [delay]: A delay before the snack is shown.
  ///
  /// - [ttsConfig]: Configuration for (Text-to-Speech) to activate snack message reading..

  static void show({
    /// The BuildContext where the snack will be displayed.
    required BuildContext context,

    /// The type of the snack (e.g., success, error).
    required SnackType type,

    /// The title to display in the snack.
    Text? title,

    /// The subtitle to display below the title in the snack.
    Text? subtitle,

    /// The duration for which the snack is visible. Defaults to 3 seconds.
    Duration? duration,

    /// Animation Duration of the snack.
    Duration? animationDuration,

    /// The offset from the top or bottom of the screen. Defaults to (0, 0).
    Offset offset = const Offset(0, 0),

    /// Whether the snack should remain visible until manually closed.
    bool persistent = false,

    /// A gradient background for the snack.
    Gradient? backgroundGradient,

    /// A list of shadow for the snack.
    List<BoxShadow>? snackShadow,

    /// The position of the snack on the screen (top or bottom).
    SnackPosition position = SnackPosition.bottom,

    /// An optional widget for custom action (e.g., a button).
    Widget? action,

    /// A delay before the snack is shown.
    Duration? delay,

    /// Configuration for Text-To-Speech service
    TTSConfiguration? ttsConfig,
  }) async {
    final OverlayState overlayState = Overlay.of(context);
    final SnackTypeConfiguration purposeDetails = getPurposeDetails(type);

    // Configure TTS properties
    if (ttsConfig != null && ttsConfig.speakOnShow) {
      await _flutterTts.setLanguage(ttsConfig.language ?? '');
      await _flutterTts.setSpeechRate(ttsConfig.speechRate ?? 0);
      await _flutterTts.setPitch(ttsConfig.pitch ?? 0);

      // Speak the message if speakOnShow is true
      if (ttsConfig.speakOnShow) {
        await _flutterTts.speak(("${title?.data}" "${subtitle?.data}"));
      }
    }

    final animationController = createAnimationController(
      overlayState,
      animationDuration,
    );

    OverlayEntry? overlayEntry;

    overlayEntry = buildOverlayEntry(
      context: context,
      title: title ?? purposeDetails.title,
      subtitle: subtitle ?? purposeDetails.subtitle,
      snackType: type,
      speakOnShow: ttsConfig?.speakOnShow ?? false,
      backgroundColor: purposeDetails.backgroundColor,
      iconColor: purposeDetails.iconColor,
      icon: purposeDetails.icon,
      elevation: purposeDetails.elevation,
      margin: purposeDetails.margin,
      borderRadius: purposeDetails.borderRadius,
      offset: offset,
      animationController: animationController,
      backgroundGradient: backgroundGradient,
      snackShadow: snackShadow,
      position: position,
      actionWidget: action,
      onClose: () async {
        animationController.reverse().then((_) {
          if (overlayEntry != null) {
            _removeOverlayEntry(overlayEntry!);
            overlayEntry = null;
          }
        });
        await _flutterTts.stop();
      },
      onDismissed: (direction) async {
        await _flutterTts.stop();
      },
    );

    // Show snack with delay if specified
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

    // Remove the snack after the specified duration if persistent is false
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

  /// Inserts the overlay entry into the screen.
  ///
  /// This method inserts the snack into the overlay and starts its entrance animation.
  ///
  /// - [overlayState]: The state of the overlay where the snack will be inserted.
  /// - [overlayEntry]: The overlay entry representing the snack.
  /// - [animationController]: The animation controller that controls the snack's animation.
  static void _insertOverlayEntry(
    OverlayState overlayState,
    OverlayEntry overlayEntry,
    AnimationController animationController,
  ) {
    overlayState.insert(overlayEntry);
    animationController.forward();
  }

  /// Removes a given overlay entry from the screen.
  ///
  /// This method removes the snack from the overlay after its exit animation is completed.
  ///
  /// - [overlayEntry]: The overlay entry to be removed.
  static void _removeOverlayEntry(OverlayEntry overlayEntry) {
    overlayEntry.remove();
    _activeEntries.remove(overlayEntry);
  }
}
