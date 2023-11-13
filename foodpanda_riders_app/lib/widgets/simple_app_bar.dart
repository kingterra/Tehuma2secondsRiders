import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final PreferredSizeWidget? bottom;

  SimpleAppBar({this.bottom, this.title});

  @override
  Size get preferredSize =>
      bottom == null ? const Size(56, kToolbarHeight) : const Size(56, 80 + kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(33, 180, 243, 1), // Replace with the desired shade of blue
              Color.fromRGBO(33, 152, 251, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 20.0,
          letterSpacing: 3,
          color: Colors.white,
          fontFamily: "Signatra",
        ),
      ),
    );
  }
}
