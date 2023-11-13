import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const YellowButton(
      {Key? key,
        required this.label,
        required this.onPressed,
        required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: Color(0xFFFD474D), borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}