import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatefulWidget {

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        body: Center(
            child: Text(
              "Cart is empty",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            )
        )
    );
  }
}
