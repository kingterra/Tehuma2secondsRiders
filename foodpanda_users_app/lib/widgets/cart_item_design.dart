import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/items.dart';

class CartItemDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber,

  });

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.03,
          vertical: MediaQuery.of(context).size.height*0.008,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        widget.model!.thumbnnailUrl!,
                        width: MediaQuery.of(context).size.width*0.175,
                        height: MediaQuery.of(context).size.width*0.175,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*0.015, horizontal: MediaQuery.of(context).size.width*0.035),
                    child: Container(
                      //color: Colors.grey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model!.title!,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${widget.quanNumber.toString()} X ${widget.model!.price.toString()} NGN",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}
