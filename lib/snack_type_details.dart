import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/snacktype_configuration.dart';

/// Gets the details of the snackbar based on its type.
///
/// This method retrieves configuration options such as background color,
/// icon, text style, etc., for the specified snackbar type.
SnackTypeConfiguration getPurposeDetails(SnackType purpose) {
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
