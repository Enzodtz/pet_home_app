import 'package:flutter/material.dart';
import 'package:pet_home_app/services/geolocation_service.dart';

class GeoLocationPermissionDialog extends StatelessWidget {
  const GeoLocationPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Needed!'),
      content: const Text(
          'This app needs location access in order to work! Please enable it on app settings.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Go'),
          onPressed: () async {
            await GeolocationService.geolocatorPlatform.openAppSettings();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class GeoLocationDisabledDialog extends StatelessWidget {
  const GeoLocationDisabledDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Needed!'),
      content: const Text(
          'This app needs location access in order to work! Please enable it on settings.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Go'),
          onPressed: () async {
            await GeolocationService.geolocatorPlatform.openLocationSettings();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
