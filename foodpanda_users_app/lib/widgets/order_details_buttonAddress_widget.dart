import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:foodpanda_users_app/maps/maps.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';




class buttonAdressWidget extends StatefulWidget {
  final Address? model;
  final int? currentindex;
  final int? value;
  final String? addresID;
  final double? totalAmount;
  final String? sellerID;

  buttonAdressWidget({
    this.model,
    this.currentindex,
    this.value,
    this.addresID,
    this.totalAmount,
    this.sellerID,
  });

  @override
  State<buttonAdressWidget> createState() => _buttonAdressWidgetState();
}

class _buttonAdressWidgetState extends State<buttonAdressWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // Select this address

        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);

      },

      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            //Address info
            Row(
              children: [
                Radio(
                  groupValue: widget.currentindex!,
                  value: widget.value!,
                  activeColor: Colors.amber,
                  onChanged: (val)
                  {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
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

                          TableRow(
                            children:[

                              const Text(
                                "Flat Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.flatNumber.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "city: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.city.toString()),
                            ],
                          ),

                          TableRow(
                            children:[

                              const Text(
                                "State: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(widget.model!.state.toString()),
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


          ],
        ),
      ),
    );
  }
}
