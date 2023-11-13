import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

import '../mainScreens/order_details_screen.dart';
import '../models/items.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholderContainer() {
      return Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
      );
    }

    print("Order ID for this card: $orderID"); // Add this line


    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => OrderDetailsScreen(orderID: orderID)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 120, // Adjusted height
        child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 110, // Adjusted height
              color: Colors.white,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        model.thumbnnailUrl != null
                            ? Container(
                          width: 70, // Adjusted width
                          height: 70, // Adjusted height
                          child: FadeInImage.assetNetwork(
                            placeholder: 'images/loading.gif',
                            image: model.thumbnnailUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                            : buildPlaceholderContainer(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                model.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "€ " + model.price.toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text(
                              "x ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                seperateQuantitiesList![index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
