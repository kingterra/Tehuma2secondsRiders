// Import statements for ParcelInProgressScreen
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanda_riders_app/assistantMethods/assistant_methods.dart';
import 'package:foodpanda_riders_app/widgets/order_card.dart';
import 'package:foodpanda_riders_app/widgets/simple_app_bar.dart';
import '../global/global.dart';
import '../widgets/progress_shimmer.dart';

// ParcelInProgressScreen
class NotYetDeliveredScreen extends StatefulWidget {
  @override
  _NotYetDeliveredScreenState createState() => _NotYetDeliveredScreenState();
}

class _NotYetDeliveredScreenState extends State<NotYetDeliveredScreen> {
  bool _isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "To be Deliver "),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
              .where("status", isEqualTo: "delivering")
                .snapshots(),
          builder: (c, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && _isFirstLoad) {
              return ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return progressShimmer();
                },
              );
            }

            _isFirstLoad = false;

            if (snapshot.hasError) {
              print("Error fetching data: ${snapshot.error}");
              return Center(child: Text("Error fetching data."));
            }

            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, index) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]))
                      .orderBy("publishedDate", descending: true)
                      .snapshots(),
                  builder: (c, snap) {
                    return snap.hasData
                        ? OrderCard(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                    )
                        : progressShimmer();
                  },
                );
              },
            )

                : Center(child: progressShimmer());
          },
        ),
      ),
    );
  }
}
