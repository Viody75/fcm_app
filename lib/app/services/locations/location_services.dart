import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationServices {
  static late Position userPosition;
  Future<Position> determineUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userPosition = await Geolocator.getCurrentPosition();
    return userPosition;
  }

  static late String userAddress;
  Future<String> getUserAddress() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    userAddress =
        '${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].subAdministrativeArea}';
    return userAddress;
  }

  Future<String> getAddress(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    return '${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].subAdministrativeArea}';
  }
}
