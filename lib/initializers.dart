import 'package:flutter/material.dart';

/// Creates animation controller
AnimationController createAnimationController(
  OverlayState overlayState,
  Duration? animationDuration,
) {
  return AnimationController(
    vsync: overlayState,
    duration: animationDuration ?? const Duration(milliseconds: 800),
  );
}
