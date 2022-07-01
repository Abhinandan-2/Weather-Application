import 'package:geolocator/geolocator.dart';

class Location {
  double? laongitude;
  double? latitude;

  Future<void> getCurLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      print(e);
    }
  }
}
