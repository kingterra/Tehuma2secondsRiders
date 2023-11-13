
import 'package:url_launcher/url_launcher.dart';

class  Maputils
{
  Maputils._();
  // latitude and longitude

  static Future<void> openMapWithPosition(double latitude, double longitude) async
  {
    String googleMapurl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await canLaunch(googleMapurl))
    {
      await launch(googleMapurl);
    }
    else
    {
      throw "could not open the map";
    }
  }

  static Future<void> openMapWithAddress(String fulladdress) async
  {
    String query = Uri.encodeComponent(fulladdress);
    String googleMapurl = "https://www.google.com/maps/search/?api=1&query=$query";

    if(await canLaunch(googleMapurl))
    {
      await launch(googleMapurl);
    }
    else
    {
      throw "could not open the map";
    }


  }
}