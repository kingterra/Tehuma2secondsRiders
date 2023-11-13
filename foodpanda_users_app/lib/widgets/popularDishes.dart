import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/menus.dart';



class popularDishes extends StatefulWidget
{
  final Menus? model;
  popularDishes({this.model});

  @override
  _popularDishesState createState() => _popularDishesState();
}



class _popularDishesState extends State<popularDishes> {
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                SizedBox(height: 100),
                Center(child: Text('Not available at the moment')),
                SizedBox(height: 100),
                /*StreamBuilder<QuerySnapshot>(
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
                      itemCount: 1,
                    );
                  },
                ),*/
              ],
    );
  }
}
