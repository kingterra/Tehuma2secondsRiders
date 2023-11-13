import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/sellsers.dart';

import '../mainScreens/CategoryScreen.dart';

class Categories extends StatefulWidget {

  Sellers? model;
  BuildContext? context;

  Categories({this.model, this.context});


  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CategoryScreen(),
            ),
          ),
      child: Container(
        height: 140,
        //width: MediaQuery.of(context).size.width,
        //margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
            /*boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 0.5,
                spreadRadius: 0.5,
              ),
            ]*/
        ),

        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 20),
            Container(
              height: 110,
              width: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [

                  SizedBox(height: 15),
                  Container(
                    height: 110,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                          child: Image.asset(
                            'images/hamburguesaCategoria.jpg',
                            height: 75.0,
                            width: 125.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 7.5),
                        Text(
                          'American',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),

            SizedBox(width: 20),
            Container(
                height: 110,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 15),
                    Container(
                      height: 110,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Image.asset(
                              'images/sushiCategoria.jpeg',
                              height: 75.0,
                              width: 125.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Text(
                              'Oriental',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),


            SizedBox(width: 20),
            Container(
                height: 110,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 15),
                    Container(
                      height: 110,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Image.asset(
                              'images/arrozAfricanoCategoria.jpg',
                              height: 75.0,
                              width: 125.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Text(
                              'African',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),


            SizedBox(width: 20),
            Container(
                height: 110,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 15),
                    Container(
                      height: 110,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Image.asset(
                              'images/pastaCategoria.png',
                              height: 75.0,
                              width: 125.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Text(
                              'Italian',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            SizedBox(width: 20),
            Container(
                height: 110,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 15),
                    Container(
                      height: 110,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Image.asset(
                              'images/perritoCategoria.jpg',
                              height: 75.0,
                              width: 125.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Text(
                              'Fast food',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            SizedBox(width: 20),
            Container(
                height: 110,
                width: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 15),
                    Container(
                      height: 110,
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            child: Image.asset(
                              'images/postresCategoria.jpg',
                              height: 75.0,
                              width: 125.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 7.5),
                          Text(
                              'Desserts',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );

  }
}