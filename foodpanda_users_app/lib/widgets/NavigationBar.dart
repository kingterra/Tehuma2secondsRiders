import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/cart_Item_Counter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class BNavigationBar extends StatefulWidget {

  final Function currentIndex;
  const BNavigationBar ({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _BNavigationBarState createState() => _BNavigationBarState();
}

class _BNavigationBarState extends State<BNavigationBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFFD474D),
    unselectedItemColor: Colors.grey.shade500,
      elevation: 20,
      iconSize: 20,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(FontAwesomeIcons.locationDot),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Stack(
            children: <Widget>[
              FaIcon(FontAwesomeIcons.cartShopping),
               Positioned(
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(0),
                  decoration:  BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Consumer<CartItemCounter>(
                    builder:(context, counter, c)
                    {

                      return Text(
                        counter.count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(FontAwesomeIcons.solidUser),
          label: 'Account',
        ),
      ],
    );
  }
}