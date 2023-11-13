import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/menus_screen.dart';
import 'package:foodpanda_users_app/models/sellsers.dart';

class SellersDesignWidget extends StatefulWidget {

  Sellers? model;
  BuildContext? context;

  SellersDesignWidget({this.model, this.context});


  @override
  State<SellersDesignWidget> createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MenusScreen(model: widget.model),
            ),
          ),
      child: Container(
        height: MediaQuery.of(context).size.height/3.1,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(/*horizontal: 10.0,*/ vertical: 7.0),
        constraints: BoxConstraints(
          //maxHeight: MediaQuery.of(context).size.height/3,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey.shade200,
          ),
        ),

        child: Stack(
          /*mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,*/
          children: <Widget>[


            /*AspectRatio(
             aspectRatio: 18 / 9,
               child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.grey.shade300,
                   borderRadius: const BorderRadius.only(
                     topLeft:  Radius.circular(15.0),
                     topRight:  Radius.circular(15.0),
                   ),
                 ),*/
            Positioned(
              top: 14,
              left: 9,
              child: ClipRRect(
                /*borderRadius: const BorderRadius.all(
                       Radius.circular(15.0),
                     ),*/
                child: Hero(
                  tag: widget.model!.sellerAvaterUrl!,
                  child: Image.network(
                    widget.model!.sellerAvaterUrl!,
                    height: MediaQuery.of(context).size.height*0.275,
                    width: MediaQuery.of(context).size.width-20,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            /*),
             ),*/

            Positioned(
              left: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width*0.9425,
              top: MediaQuery.of(context).size.height*0.2,
              child: Container(
                width: MediaQuery.of(context).size.width*0.875,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height*0.15,
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  /*border: Border.all(
                            width: 2,
                              color: Colors.grey.shade200),*/
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),),
                child: Column(
                  children: <Widget>[
                    Container(
                      //color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height*0.065,
                        maxHeight: double.infinity,
                      ),
                      //color: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 12.5),
                        child: Text(
                          widget.model!.sellerName!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.035,
                      //color: Colors.red,
                      /*decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              width: 1.0,
                              color: Colors.grey.shade200,
                            ),
                          ),*/
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[

                          Padding(
                            padding: EdgeInsets.only(left:20.0, bottom: 5),
                            child: Text(
                              '2-5'' km away  -  ' '€€€' ,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right:20.0, bottom: 5),
                            child: Text(
                              '⭐⭐' ' 2.3',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}