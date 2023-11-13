import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/assistantMethods/assistan_methods.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/PassSellerID.dart';



class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {

   int numero = 0;
  TextEditingController counterTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => showModalBottomSheet(

        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),

        context: context,
        builder: (context) => buildSheet(),
      ),
      /*{
        Navigator.push(context, MaterialPageRoute(builder: (C)=> ItemDetailsScreen(model: widget.model)));
      },*/
      child: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              widget.model!.thumbnnailUrl!,
              height: 80.0,
              width: 80.0,
              //image: AssetImage(restaurant.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                //color: Colors.red,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:10.0, top: 8),
                          child: Text(
                            widget.model!.title!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(left:10.0, top: 10),
                          child: Text(
                            "Price: ${widget.model!.price.toString()} NGN",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 const SizedBox(width: 30),
                ],
              ),
            ),
            //RatingStars(restaurant.rating),
          ),
        ],
      ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );

  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          controller: controller,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 5,
                //width: 10,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Image.network(
              widget.model!.thumbnnailUrl.toString(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.125, right: 20.0, top: 20.0 ),
              child: NumberInputWithIncrementDecrement(
                numberFieldDecoration: InputDecoration(
                    border: InputBorder.none
                ),
                widgetContainerDecoration: BoxDecoration(

                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    )
                ),
                incIconDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                separateIcons: true,
                decIconDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black
                ),
                controller: counterTextEditingController,
                scaleWidth: 0.7,
                scaleHeight: 0.7,
                incIconSize: 35,
                decIconSize: 35,
                incIcon: FontAwesomeIcons.plus,
                decIcon: FontAwesomeIcons.minus,
                incDecBgColor: Colors.white,
                min: 1,
                max: 9,
                initialValue: 1,
                buttonArrangement: ButtonArrangement.incRightDecLeft,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: addItem, icon: Icon(FontAwesomeIcons.plus)),
                  Text("Items: $_quantity"),
                  IconButton(onPressed: removeItem, icon: Icon(FontAwesomeIcons.minus)),

                ],
              )*/
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.model!.title.toString(),
                style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.model!.longDescription.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.normal , fontSize: 16),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.model!.price.toString()+ " NGN",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22.5, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Center(
              child: InkWell(
                onTap: ()
                {
                  Provider.of<PassSellerID>(context, listen: false).PassID(widget.model?.sellersUID);

                  int itemCounter = int.parse(counterTextEditingController.text);
                  //check if item exist already in cart

                  List<String> separateItemIDsList = separateItemIDs();
                  separateItemIDsList.contains(widget.model!.itemID)
                      ? Fluttertoast.showToast(msg: "Item is already in cart.")
                      :

                  //add to cart function

                  addItemToCart(widget.model!.itemID, context, itemCounter);
                  Navigator.pop(context);

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFD474D),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white
                      )
                    ),
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );


}
