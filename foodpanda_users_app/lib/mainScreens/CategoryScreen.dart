import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';

class CategoryScreen extends StatefulWidget {

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Category"),
      body: SafeArea(
        child: Container(
        ),
      )
    );
  }
}
