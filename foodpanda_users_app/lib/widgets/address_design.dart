import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/addressIDchanger.dart';
import '../models/address.dart';




class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentindex;
  final int? value;
  final String? addresID;
  final double? totalAmount;
  final String? sellerID;

  AddressDesign({
    this.model,
    this.currentindex,
    this.value,
    this.addresID,
    this.totalAmount,
    this.sellerID,
});

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // Select this address

        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);

      },

      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            //Address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentindex!,
                  value: widget.value!,
                  activeColor: Colors.blue,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                    Provider.of<AddressIDChanger>(context, listen: false).display(widget.addresID);
                    print(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,

                      child: Table(
                        children: [
                          /*TableRow(
                            children:[

                              const Text(
                                "Name: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.name.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                             const Text(
                                "Phone number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.phoneNumber.toString()),
                            ],
                          ),*/
                          TableRow(
                            children:[
                              /*Text(
                                "Full address: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),*/

                              Text(widget.model!.fullAddress.toString()),
                            ],
                          ),
                        ],
                      ),

                    ),



                  ],
                ),
              ],
            ),

            //check the address on google map
            /*
            ElevatedButton(

              child: const Text("Check on Maps"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              onPressed: ()
              {

                Maputils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);

              },

            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(

              child: const Text("Proceed"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green
              ),

              onPressed: ()
              {

              },


            )
                : Container(),
             */
          ],
        ),
      ),
    );
  }
}
