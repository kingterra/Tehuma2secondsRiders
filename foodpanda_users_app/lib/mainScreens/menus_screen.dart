import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodpanda_users_app/models/menus.dart';
import 'package:foodpanda_users_app/models/sellsers.dart';
import 'package:foodpanda_users_app/widgets/menus_design.dart';
import 'package:foodpanda_users_app/widgets/progress_bar.dart';
import 'package:like_button/like_button.dart';
import '../widgets/popularDishes.dart';


class MenusScreen extends StatefulWidget {
  final Sellers? model;

  MenusScreen({this.model});


  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader( title: widget.model!.sellerName.toString() + " Menus")),
          //Creates a new StreamBuilder that builds
          // itself based on the latest snapshot

          SliverAppBar(
            pinned: true,
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFFD474D),
            stretch: true,
            actions: [
                Container(
                  width: MediaQuery.of(context).size.width/4.5,

                    child: LikeButton(
                      circleColor:
                      CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red.shade900 : Colors.white,
                          size: 30,
                        );
                      },
                    ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Container(width: MediaQuery.of(context).size.width/1.65,
                child: Text(
                  widget.model!.sellerName!,
                    style: TextStyle(
                      color: Colors.white,
                    )
                ),
              ),
              background: Image.network(
                  widget.model!.sellerAvaterUrl!,
                  height: MediaQuery.of(context).size.height/5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle],
            ),
            expandedHeight: MediaQuery.of(context).size.height/5,
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const <Widget>[

                              Text('⭐ ⭐ ⭐ ⭐' + '      ' + '4.2'),
                              Text(
                                '3-5 Km away',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //RatingStars(widget.restaurant.rating),
                        SizedBox(height: 15.0),

                      ],
                    ),
                  ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width/20),
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),

          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(widget.model!.sellerUID)
                .collection("menus")
                .orderBy("publishedDate", descending: true).snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(

                child: Center(child: circularProgress(),),

              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return MenusDesignWidget(
                    model: model,
                    context: context,

                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },


          ),
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/20),
                Text(
                  'Most popular',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: popularDishes(),
          )
        ],
      ),
    );
  }
}



