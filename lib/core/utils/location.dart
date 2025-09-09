import 'package:geolocator/geolocator.dart';

import '../widget/custom_progress_indicator.dart';

class LocationHelper{
  static Future<Position> getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      bool opened = await Geolocator.openLocationSettings();
      CustomProgressIndicator.hideLoading();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        CustomProgressIndicator.hideLoading();
        return Future.error('Location permissions are denied');

      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}