import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/items.dart';

class OrderDetailsScreenDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  OrderDetailsScreenDesign({
    this.model,
    this.context,
    this.quanNumber,

  });

  @override
  State<OrderDetailsScreenDesign> createState() => _OrderDetailsScreenDesignState();
}

class _OrderDetailsScreenDesignState extends State<OrderDetailsScreenDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03, bottom: MediaQuery.of(context).size.height*0.02),
        child: Row(
          children: [
            Image.network(
              widget.model!.thumbnnailUrl!,
              width: MediaQuery.of(context).size.width*0.175,
              height: MediaQuery.of(context).size.width*0.175,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*0.03),
                    Text(
                      widget.model!.title!,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*0.075),
                    Text(
                      "${widget.quanNumber.toString()} X ${widget.model!.price.toString()} NGN",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
