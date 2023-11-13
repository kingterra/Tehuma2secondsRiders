
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:foodpanda_users_app/models/items.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/widgets/items_design.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';
class ItemsScreen extends StatefulWidget
{
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: widget.model!.menuTitle.toString(),),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            //SliverToBoxAdapter(child: SizedBox(height: 100)),
            SliverToBoxAdapter(
                child: Container(
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellersUID)
                  .collection("menus")
                  .doc(widget.model!.menuID)
                  .collection("items")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),
                )
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return ItemsDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
