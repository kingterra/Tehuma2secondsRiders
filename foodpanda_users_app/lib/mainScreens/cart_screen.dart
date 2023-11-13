import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/assistantMethods/assistan_methods.dart';
import 'package:foodpanda_users_app/assistantMethods/cart_Item_Counter.dart';
import 'package:foodpanda_users_app/mainScreens/address_screen.dart';
import 'package:foodpanda_users_app/mainScreens/order_details.dart';
import 'package:foodpanda_users_app/models/items.dart';
import 'package:foodpanda_users_app/splashScreen/splash_screen.dart';
import 'package:foodpanda_users_app/widgets/app_bar.dart';
import 'package:foodpanda_users_app/widgets/cart_item_design.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:foodpanda_users_app/widgets/text_widget_header.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/change_selected.dart';
import '../assistantMethods/total_amount.dart';

class CartScreen extends StatefulWidget {
  final String? sellerUID;
  CartScreen({this.sellerUID});


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? separateItemQuantityList;

  num totalAmount = 0;


  @override
  void initState() {
    if (mounted) {

      super.initState();
      totalAmount =0;
      Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);
      separateItemQuantityList= separateItemQuantities();

    }
  }


  /*@override
  void initState() {
    super.initState();


    separateItemQuantityList= separateItemQuantities();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomSheet: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
          child: Container(
            height: MediaQuery.of(context).size.height/14,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFFD474D)),

            child: TextButton(
              child: Text(
                'Checkout',
                style: TextStyle(
                  //fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c)=> OrderDetailsScreen(
                      //we pass the total amount and the sellers id
                      totalAmount: totalAmount.toDouble(),
                      sellerUID: widget.sellerUID,
                      NumeroTextoMetodoPago: Provider.of<ChangeSelected>(context).selectedValued,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          //overalltotalprice
          SliverToBoxAdapter(
          ),

          SliverToBoxAdapter(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
                  {
                    return Center(
                      child: cartProvider.count ==0
                        ? Container()
                        : Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height*0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Total price: ",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${amountProvider.tAmount.toString()}",
                                    style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 18,
                                        //fontWeight: FontWeight.w300,
                                        fontFamily: "FredokaOne"
                                    ),
                                  ),
                                  Text(
                                    " NGN",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2),
                                child: IconButton(
                                  icon: FaIcon(FontAwesomeIcons.solidTrashCan),
                                  onPressed: () {
                                    clearCartNow(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
                                    Fluttertoast.showToast(msg: "Cart has been cleaned");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    );
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.008,
                  )
                ],
              ),
            ),
          ),

          //display cart item with quantity number
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID", whereIn: separateItemIDs())
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : snapshot.data!.docs.length == 0
                  ? //startBuildingCart()
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return CartItemDesign(
                    model: model,
                    context: context,
                    quanNumber: separateItemQuantityList![index],
                  );
                },
                  childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                ),
              )
                  : SliverList(
                delegate: SliverChildBuilderDelegate((context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );

                  // we check if we have the first item index in the cart
                  if(index ==0){
                    totalAmount =0;
                    //we multiply the number of item times the price
                    totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                  }else {

                    //if the item index is greater than 0 we will
                    //keep geting the total amount of the rest item index
                    totalAmount = totalAmount + (model.price! * separateItemQuantityList![index]);
                  }

                  // if we get to the last cart item index list
                  //calculate me the total item product

                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp)
                  {
                    //with the provider we update the total amount in real time
                    Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());
                  });

                  return CartItemDesign(
                    model: model,
                    context: context,
                    quanNumber: separateItemQuantityList![index],
                  );
                },
                  childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).size.height*0.2)
          )
        ],
      ),
    );
  }
}