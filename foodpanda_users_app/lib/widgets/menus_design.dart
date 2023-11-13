import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/items_screen.dart';
import 'package:foodpanda_users_app/models/menus.dart';


class MenusDesignWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.model, this.context});


  @override
  State<MenusDesignWidget> createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },

      child: Container(
        height: MediaQuery.of(context).size.width/3,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width/30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey.shade200,
          ),
        ),

        child: Stack(
          /*child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,*/
            children: <Widget>[

              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                /*child: Hero(
                  tag: widget.model!.sellerAvaterUrl!,*/
                child: Image.network(
                  widget.model!.thumbnnailUrl!,
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width,
                  //image: AssetImage(restaurant.imageUrl),
                  fit: BoxFit.cover,
                ),
                //),
              ),
              Opacity(
                  opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black,
                  )
                ),
              ),
              Center(
                child: Text(
                  widget.model!.menuTitle.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //RatingStars(restaurant.rating),
              ),
            ],
          ),
        ),
      //),
    );

  }
}
