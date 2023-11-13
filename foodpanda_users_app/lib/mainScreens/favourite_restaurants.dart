import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';

class FavouriteRestaurants extends StatefulWidget {
  const FavouriteRestaurants({Key? key}) : super(key: key);

  @override
  State<FavouriteRestaurants> createState() => _FavouriteRestaurantsState();
}

class _FavouriteRestaurantsState extends State<FavouriteRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Favourite restaurants"),
    );
  }
}
