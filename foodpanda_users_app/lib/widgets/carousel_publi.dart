import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselPubli extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      //height: 300,
        child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(1)
          ),
          const SizedBox(
            height: 15,
          ),
          CarouselSlider(items: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2.0,2.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
                ],
                image: DecorationImage(image: AssetImage("images/Publicidad1.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2.0,2.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
                ],
                image: DecorationImage(image: AssetImage("images/Publicidad2.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2.0,2.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
                ],
                image: DecorationImage(image: AssetImage("images/Publicidad3.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2.0,2.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
                ],
                image: DecorationImage(image: AssetImage("images/Publicidad4.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.white, offset: Offset(2.0,2.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                ),
                ],
                image: DecorationImage(image: AssetImage("images/Publicidad5.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height/2.75,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayCurve: Curves.ease,
              //enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
            ),
          ),



          /*
          Carousel(
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.lightGreenAccent,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.transparent,
            dotVerticalPadding: 5.0,
            dotPosition: DotPosition.bottomCenter,
            images: [
              Image.asset(
                'pastaCategoria.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'pastaCategoria.png',
                fit: BoxFit.cover,
              ),
              Image.asset(
                'pastaCategoria.png',
                fit: BoxFit.cover,
              ),
            ],
          ),
*/

        ],
        ),
    );
  }
}