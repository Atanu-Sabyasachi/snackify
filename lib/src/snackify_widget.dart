// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SnackifyWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;
  final Duration animationDuration;
  final double snackbarHeight;
  final double snackbarWidth;
  final Curve animationCurve;

  const SnackifyWidget({
    super.key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.duration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 300),
    this.snackbarHeight = 50.0,
    this.snackbarWidth = double.infinity,
    this.animationCurve = Curves.easeInOut,
  });

  @override
  _SnackifyWidgetState createState() => _SnackifyWidgetState();
}

class _SnackifyWidgetState extends State<SnackifyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));

    _controller.forward();
    _hideSnackbar();
  }

  void _hideSnackbar() {
    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: widget.backgroundColor,
        child: Container(
          height: widget.snackbarHeight,
          width: widget.snackbarWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Text(
              widget.message,
              style: TextStyle(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackify(BuildContext context, String message) {
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    barrierDismissible: true,
    pageBuilder: (context, _, __) => SnackifyWidget(message: message),
  ));
}
