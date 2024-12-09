/// Defines different purposes for the snack.
enum SnackType {
  /// Snack for success messages
  success,

  /// Snack for error messages
  error,

  /// Snack for warning messages
  warning,

  /// Snack for informations to user
  info,
}

/// Different snack position.
enum SnackPosition {
  /// Snack will be shown on top of screen
  top,

  /// Snack will be shown on bottom(default) of screen
  bottom,
}
