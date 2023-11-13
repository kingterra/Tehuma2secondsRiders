import 'package:flutter/material.dart';

class circularProgress extends StatelessWidget {
  final Color backgroundColor;
  final Color progressColor;
  final double size;
  final double strokeWidth;

  circularProgress({
    this.backgroundColor = Colors.blue,
    this.progressColor = Colors.red,
    this.size = 60.0,
    this.strokeWidth = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
