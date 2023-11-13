import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/assistan_methods.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ItemDetailsScreen extends StatefulWidget {

  final Items? model;
  ItemDetailsScreen({this.model});


  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  TextEditingController counterTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.model!.thumbnnailUrl.toString(),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: NumberInputPrefabbed.roundedButtons(
              controller: counterTextEditingController,
              incDecBgColor: Colors.amber,
              min: 1,
              max: 9,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incLeftDecRight,

            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.normal , fontSize: 14),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.price.toString()+ " ₦",
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30),
            ),
          ),

          const SizedBox(height: 10,),

          Center(
            child: InkWell(
              onTap: ()
              {
                int itemCounter = int.parse(counterTextEditingController.text);
                //check if item exist already in cart

                List<String> separateItemIDsList = separateItemIDs();
                separateItemIDsList.contains(widget.model!.itemID)
                    ? Fluttertoast.showToast(msg: "Item is already in cart.")
                    :

                //add to cart function

                addItemToCart(widget.model!.itemID, context, itemCounter);

              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.cyan,
                        Colors.amber,
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),

              ),
            ),
          ),
        ],
      ),

    );
  }
}
