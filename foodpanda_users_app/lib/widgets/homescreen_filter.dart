import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/price_model.dart';

class homescreenFilter extends StatefulWidget {
  const homescreenFilter({Key? key}) : super(key: key);

  @override
  State<homescreenFilter> createState() => _homescreenFilterState();
}

class _homescreenFilterState extends State<homescreenFilter> {


  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );

  @override

  Widget build(BuildContext context) => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(top: 0.0),
        child: ListView(
          controller: controller,
          children: [

            Container(
              height: MediaQuery.of(context).size.height/12,
              decoration: BoxDecoration(
                //color: Colors.grey.shade100,
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.black45),
                  )
              ),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width*0.025),
                  IconButton(
                      icon: Icon(Icons.highlight_off),
                      iconSize: 33,
                      color: Colors.blue.shade600,
                      onPressed: () { Navigator.pop(context); }
                    ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25),
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height*0.82,
              color: Colors.grey.shade100,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Row(
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CustomPriceFilter(prices: Price.prices),
                    Row(
                      children: [
                        Text(
                          'Order By',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.05),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

}

class CustomPriceFilter extends StatelessWidget {
  final List<Price> prices;
  const CustomPriceFilter({
    Key? key,
    required this.prices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: prices
        .map(
          (price) => Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.02,
              bottom: MediaQuery.of(context).size.height*0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width*0.1,
              vertical:  MediaQuery.of(context).size.width*0.025,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(price.price),
          )
        )
        .toList(),
    );
  }
}

