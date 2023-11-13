import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodpanda_users_app/widgets/simple_app_bar.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/change_selected.dart';
import '../mainScreens/order_details.dart';

class SelectPayment extends StatefulWidget {

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {


  @override
  Widget build(BuildContext context) {
    return Material(
          color: Colors.grey.shade200,
            child: Scaffold(
              appBar: SimpleAppBar(title: "Select payment"),
              bottomSheet: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                  child: Container(
                    height: MediaQuery.of(context).size.height/14,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFFD474D),),

                    child: TextButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          //fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen()));
                      },
                    ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0,),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /*Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${widget.totalAmount} USD',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total order',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              '${widget.totalAmount} Naira',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Shipping Coast',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              '10.00' + (' USD'),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            RadioListTile(
                              activeColor: Color(0xFFFD474D),
                              value: 1,
                              groupValue: Provider.of<ChangeSelected>(context).selectedValued,
                              onChanged: (int? value) {

                                setState(() {
                                  Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!);
                                });

                              },
                              title: const Text('Cash on delivery'),
                              subtitle: const Text('Pay with cash'),
                            ),
                            RadioListTile(
                              activeColor: Color(0xFFFD474D),
                              value: 2,
                              groupValue: Provider.of<ChangeSelected>(context).selectedValued,
                              onChanged: (int? value) {

                                setState(() {
                                  Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!);
                                });

                              },
                              title:
                              const Text('Pay via visa / Master Card'),
                              subtitle: Row(
                                children: const [
                                  Icon(Icons.payment, color: Colors.black87),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Icon(
                                        FontAwesomeIcons.ccMastercard, color: Colors.black87),
                                  ),
                                  Icon(FontAwesomeIcons.ccVisa, color: Colors.black87),
                                ],
                              ),
                            ),
                            RadioListTile(
                              activeColor: Color(0xFFFD474D),
                              value: 3,
                              groupValue: Provider.of<ChangeSelected>(context).selectedValued,
                              onChanged: (int? value) {
                                setState(() {
                                  Provider.of<ChangeSelected>(context, listen: false).ChangeNumber(value!);
                                });

                              },
                              title: const Text('Pay via Paypal'),
                              subtitle: Row(
                                children: const [
                                  Icon(
                                    FontAwesomeIcons.paypal, color: Colors.black87),
                                  SizedBox(width: 15),
                                  Icon(
                                    FontAwesomeIcons.ccPaypal, color: Colors.black87),
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
            ),
        );
  }
}
