
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {

    await Geolocator.requestPermission();
    // izin almak için bu kodlama gerek.

    var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // hassasiyeti high olsun.

    latitude = location.latitude;
    longitude = location.longitude;
  }
}
