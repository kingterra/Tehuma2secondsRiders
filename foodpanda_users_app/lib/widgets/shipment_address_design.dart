import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/models/address.dart';

class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;

  ShipmentAddressDesign({this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding:  EdgeInsets.all(10.0),
         child: Text(
            'Shipment Details:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
       ),
        SizedBox(
          width: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                 const Text(
                    "Name",
                    style: TextStyle(
                       color: Colors.black,
                    ),
                  ),

                  Text(model!.name!),
                ]
              ),

              TableRow(
                  children: [
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),

                    Text(model!.phoneNumber!),
                  ]
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
           model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
