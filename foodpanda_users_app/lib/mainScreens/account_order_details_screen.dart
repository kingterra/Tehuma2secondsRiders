import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/global/global.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:foodpanda_users_app/widgets/shipment_address_design.dart';
import 'package:intl/intl.dart';

import '../widgets/status_banner.dart';

class AccountOrderDetailsScreen extends StatefulWidget {
  final String? orderID;

  AccountOrderDetailsScreen({this.orderID});



  @override
  State<AccountOrderDetailsScreen> createState() => _AccountOrderDetailsScreenState();
}

class _AccountOrderDetailsScreenState extends State<AccountOrderDetailsScreen> {

  String? orderStateText = "";
  late Color orderStateColor;
  late IconData orderStateIcon;
  late Color orderStateIConColor;


  Row orderstate (orderStateText, orderStateColorm, orderStateIcon, orderStateIconColor) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              color: orderStateColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 3,
                color: Color(0xFFFD474D),
              )
          ),
          child: Center(
            child: FaIcon(FontAwesomeIcons.check, color: orderStateIconColor,),
          ),
        ),
        SizedBox(width: 25),
        Container(
          width: 25,
          child: FaIcon(orderStateIcon, color: Color(0xFFFD474D))
        ),
        SizedBox(width: 25),
        Text(
          orderStateText,
          style: TextStyle(
          ),
        )
      ],
    );
  }

  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future:  FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .doc(widget.orderID!)
                .get(),

            builder: (c, snapshot)
            {
              Map? dataMap;
              if(snapshot.hasData)
              {
                dataMap = snapshot.data!.data()! as Map<String, dynamic>;
                orderStatus = dataMap["status"].toString();
              }
              return snapshot.hasData
                  ? Container(
                child: Column(
                  children: [
                    StatusBanner(
                      status: dataMap!["isSuccess"],
                      orderStatus: orderStatus,
                    ),
                const SizedBox(
                  height: 10.0,

                ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dataMap["totalAmount"].toString() + " NGN",

                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,


                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       "Order Id = " +widget.orderID!,
                        style: const TextStyle(
                          fontSize: 16,

                        ),
                      ),
                    ),

                    Text(
                      "Order at " +
                          DateFormat("dd MMM, yyyy - hh:mm aa")
                              .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"])),),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),

                    Divider(thickness:  4,),

                    orderStatus=="ended" ?
                    Column(
                      children: [
                        Row(
                          children: [

                            ],
                        )
                      ],
                    )
                      : orderStatus=="normal"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20),
                      child: Column(
                        children: [
                          orderstate(orderStateText = "Order placed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.file, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Order processed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.fileCircleCheck, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Preparing", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.bowlFood, orderStateIConColor = Color(0xFFFD474D)),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Colors.white, width: 4, height: 25),
                            ],
                          ),
                          orderstate(orderStateText = "Delivering", orderStateColor = Colors.white, orderStateIcon = FontAwesomeIcons.personBiking, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Colors.white, width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Order prepared", orderStateColor = Colors.white, orderStateIcon = FontAwesomeIcons.basketShopping, orderStateIConColor = Colors.white),
                        ],
                      ),
                    )
                    /*Image.asset("images/delivered.jpg")*/
                    : orderStatus == "delivering"?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20),
                      child: Column(
                          children: [
                            orderstate(orderStateText = "Order placed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.file, orderStateIConColor = Colors.white),
                            Row(
                              children: [
                                SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                              ],
                            ),
                            orderstate(orderStateText = "Order processed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.fileCircleCheck, orderStateIConColor = Colors.white),
                            Row(
                              children: [
                                SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                              ],
                            ),
                            orderstate(orderStateText = "Preparing", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.bowlFood, orderStateIConColor = Colors.white),
                            Row(
                              children: [
                                SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                              ],
                            ),
                            orderstate(orderStateText = "Delivering", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.personBiking, orderStateIConColor = Colors.white),
                            Row(
                              children: [
                                SizedBox(width: 15), Container(color: Colors.white, width: 4, height: 25,),
                              ],
                            ),
                            orderstate(orderStateText = "Order prepared", orderStateColor = Colors.white, orderStateIcon = FontAwesomeIcons.basketShopping, orderStateIConColor = Colors.white),
                          ],
                        ),
                    )
                    :
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20),
                      child: Column(
                        children: [
                          orderstate(orderStateText = "Order placed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.file, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Order processed", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.fileCircleCheck, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Preparing", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.bowlFood, orderStateIConColor = Colors.white),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Color(0xFFFD474D), width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Delivering", orderStateColor = Color(0xFFFD474D), orderStateIcon = FontAwesomeIcons.personBiking, orderStateIConColor = Color(0xFFFD474D)),
                          Row(
                            children: [
                              SizedBox(width: 15), Container(color: Colors.white, width: 4, height: 25,),
                            ],
                          ),
                          orderstate(orderStateText = "Ready to pickup", orderStateColor = Colors.white, orderStateIcon = FontAwesomeIcons.basketShopping, orderStateIConColor = Colors.white),
                        ],
                      ),
                    ),
                    /*Image.asset("images/state.jpg"),*/

                   const  Divider(thickness:  4,),

                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(sharedPreferences!.getString("uid"))
                          .collection("userAddress")
                          .doc(dataMap["addressID"])
                          .get(),

                      builder: (c, snapshot)
                      {
                        return snapshot.hasData
                            ? ShipmentAddressDesign(
                          model: Address.fromjson(
                            snapshot.data!.data()! as Map<String, dynamic>
                          ),
                        )
                            : Center(child: circularProgress(),);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/6,)
                  ],
                ),

              )

                  : Center(child: circularProgress(),);

            },

          ),
        ),
        bottomSheet: Container(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
            child: Container(
              height: MediaQuery.of(context).size.height/14,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFFD474D)),

              child: TextButton(
                child: Text(
                  'Go back',
                  style: TextStyle(
                    //fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
