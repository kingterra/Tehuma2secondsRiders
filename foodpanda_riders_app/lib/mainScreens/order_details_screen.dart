import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_riders_app/global/global.dart';
import 'package:foodpanda_riders_app/models/address.dart';
import 'package:foodpanda_riders_app/widgets/progress_bar.dart';
import 'package:foodpanda_riders_app/widgets/shipment_address_design.dart';
import 'package:intl/intl.dart';

import '../widgets/sliver_header.dart';
import '../widgets/status_banner.dart';
import 'home_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;

  OrderDetailsScreen({this.orderID});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";
  String orderByUser = "";
  String sellerUID="";

  getOrderInfo() {
    print("Order ID in getOrderInfo(): ${widget.orderID}");
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderID)
        .get()
        .then((DocumentSnapshot) {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderByUser = DocumentSnapshot.data()!["orderBy"].toString();
      sellerUID = DocumentSnapshot.data()!["sellerUID"].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    print("Order ID in OrderDetailsScreen: ${widget.orderID}");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200, // Adjust the height as needed
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Order Details'),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              child: StatusBanner(
                status: true, // Change this to your desired status
                orderStatus: orderStatus,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("orders")
                        .doc(widget.orderID)
                        .get(),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: circularProgress());
                        }

                        if (snapshot.hasError) {
                          print("Error fetching data: ${snapshot.error}");
                          return Center(child: Text("Error fetching data."));
                        }

                        if (snapshot.hasData) {
                          Map? dataMap = snapshot.data!.data()! as Map<String, dynamic>;
                          orderStatus = dataMap["status"].toString();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "€  " + dataMap["totalAmount"].toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Order Id: ${widget.orderID!}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                "Order at: ${DateFormat("dd MMMM, yyyy - hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"])))}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              const Divider(thickness: 2),
                              if (orderStatus == "ended")
                                Image.asset("images/success.jpg")
                              else
                                Image.asset("images/confirm_pick.png"),
                              const Divider(thickness: 2),
                              FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(orderByUser)
                                    .collection("userAddress")
                                    .doc(dataMap["addressID"])
                                    .get(),
                                builder: (context, snapshot) {
                                  try {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: circularProgress());
                                    }

                                    if (snapshot.hasError) {
                                      print("Error fetching data: ${snapshot.error}");
                                      return Center(child: Text("Error fetching data."));
                                    }

                                    if (snapshot.hasData) {
                                      return ShipmentAddressDesign(
                                        model: Address.fromjson(
                                            snapshot.data!.data()! as Map<String, dynamic>
                                        ),
                                        orderStatus: orderStatus,
                                        orderId: widget.orderID,
                                        sellerUID: sellerUID,
                                        orderByUser: orderByUser,
                                      );
                                    } else {
                                      return Center(child: Text("No data found."));
                                    }
                                  } catch (e) {
                                    print("An error occurred: $e");
                                    return Center(child: Text("An error occurred."));
                                  }
                                },
                              ),
                            ],
                          );
                        } else {
                          return Center(child: Text("No data found."));
                        }
                      } catch (e) {
                        print("An error occurred: $e");
                        return Center(child: Text("An error occurred."));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
