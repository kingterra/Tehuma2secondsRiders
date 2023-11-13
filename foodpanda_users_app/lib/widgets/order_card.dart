import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/mainScreens/account_order_details_screen.dart';
import 'package:foodpanda_users_app/models/items.dart';


class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        //todo
        Navigator.push(context,  MaterialPageRoute(builder: (c)=> AccountOrderDetailsScreen (orderID: orderID)));
      },
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12,
                Colors.white54,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 125,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}




Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey[200],
    child: Row(
      children: [
        Image.network(model.thumbnnailUrl!, width: 120,),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Acme",
                      ),
                    ),
                  ),
                  Text(
                    model.price.toString() + " NGN",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "x " + seperateQuantitiesList,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 27
                        ,
                        fontFamily: "Acme",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}