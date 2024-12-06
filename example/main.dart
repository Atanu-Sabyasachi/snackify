import 'package:flutter/material.dart';
import 'package:snackify/src/snackify_widget.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackify Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Snackify.show(
              context: context,
              message: "This is a customizable Snackify Snackbar !",
              backgroundColor: Colors.indigo,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              iconColor: Colors.yellow,
              icon: Icons.info_outline,
              elevation: 10.0,
              margin: const EdgeInsets.all(16.0),
              borderRadius: BorderRadius.circular(12.0),
              duration: const Duration(seconds: 5),
              animationDuration: const Duration(milliseconds: 1000),
              offset: const Offset(0, 50),
              animationBuilder: (context, animation, child) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              customWidget: null, // Leave null to use default content
              stackSnackbars: true,
              persistent: false,
              backgroundGradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
              position: SnackifyPosition.bottom,
              //delay: const Duration(seconds: 1),
              useTheme: false,
            );
          },
          child: const Text("Show Snackify Snackbar"),
        ),
      ),
    );
  }
}
