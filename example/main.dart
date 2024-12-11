import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snackify/enums/snack_enums.dart';
import 'package:snackify/snackify.dart';
import 'package:snackify/tts_config.dart';

void main() {
  runApp(const MyApp());
}

/// Example Flutter application demonstrating the use of Snackify with all properties.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snackify Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackify Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Snackify.show(
                  context: context,
                  type: SnackType.success,
                  title: Text(
                    'Well Done !',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'You have successfully done it !',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  ttsConfig: TTSConfiguration(speakOnShow: true),
                  duration: const Duration(seconds: 3),
                  animationDuration: const Duration(milliseconds: 1000),
                  backgroundGradient: const LinearGradient(
                    colors: [
                      Colors.teal,
                      Colors.greenAccent,
                    ],
                  ),
                  position: SnackPosition.bottom,
                );
              },
              child: const Text("Success"),
            ),
            ElevatedButton(
              onPressed: () {
                Snackify.show(
                  context: context,
                  type: SnackType.error,
                  backgroundGradient: const LinearGradient(colors: [
                    Colors.redAccent,
                    Colors.deepOrange,
                  ]),
                  duration: const Duration(seconds: 3),
                  title: Text(
                    'Oops ...',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Wrong password !',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  ttsConfig: TTSConfiguration(speakOnShow: true),
                  animationDuration: const Duration(milliseconds: 1000),
                  position: SnackPosition.bottom,
                );
              },
              child: const Text("Error"),
            ),
            ElevatedButton(
              onPressed: () {
                Snackify.show(
                  context: context,
                  type: SnackType.warning,
                  duration: const Duration(seconds: 3),
                  title: Text(
                    'Password is weak !',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Try to enter a strong password.',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  action: TextButton(
                    onPressed: () {
                      log('Undo button is pressed');
                    },
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Undo',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ttsConfig: TTSConfiguration(speakOnShow: true),
                  animationDuration: const Duration(milliseconds: 1000),
                  backgroundGradient: const LinearGradient(colors: [
                    Colors.orange,
                    Colors.yellow,
                  ]),
                  position: SnackPosition.bottom,
                );
              },
              child: const Text("Warning"),
            ),
            ElevatedButton(
              onPressed: () {
                Snackify.show(
                  context: context,
                  type: SnackType.info,
                  duration: const Duration(seconds: 3),
                  title: Text(
                    'Do you know ?',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'You have ₹156 cash in your wallet !',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                  snackShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(4, 4),
                    ),
                  ],
                  persistent: true,
                  ttsConfig: TTSConfiguration(speakOnShow: true),
                  animationDuration: const Duration(milliseconds: 1000),
                  backgroundGradient: const LinearGradient(colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ]),
                  position: SnackPosition.bottom,
                );
              },
              child: const Text("Info"),
            ),
          ],
        ),
      ),
    );
  }
}
