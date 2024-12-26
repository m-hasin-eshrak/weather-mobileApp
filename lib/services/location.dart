import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
