import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget
{
 final bool? status;
 final String? orderStatus;

 StatusBanner({this.status, this.orderStatus});

  @override
  Widget build(BuildContext context)
  {
    String? massage;
    IconData iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? massage = "successfully" : massage = "unsuccessfully";
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFD474D),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          GestureDetector(
            onTap: ()
            {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),

          const  SizedBox(
            width: 20,
          ),
          Text(
            orderStatus == "ended"
                ? "Parcel Delivered $massage"
                : "Order placed $massage",

            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),

          const  SizedBox(
            width: 15,
          ),
          Center(
            child: Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
