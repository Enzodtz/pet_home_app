import 'package:geolocator/geolocator.dart';

class GeolocationService {
  static final GeolocatorPlatform geolocatorPlatform =
      GeolocatorPlatform.instance;

  static Future<void> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      throw const LocationServiceDisabledException();
    }

    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        throw const PermissionDeniedException('');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw const PermissionDeniedException('');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    // print("Permission granted");
  }

  static Future<Position> getCurrentPosition() async {
    // await handlePermission(context);

    final status = await geolocatorPlatform.getLocationAccuracy();
    final position = await geolocatorPlatform.getCurrentPosition();

    print("Current position:");
    print(position.toString());
    print("Precision: $status");

    return position;
  }
}
