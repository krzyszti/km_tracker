import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await getLocation();
}

double calculateDistance(Position pointA, Position pointB) {
  return Geolocator.distanceBetween(
      pointA.latitude, pointA.longitude, pointB.latitude, pointB.longitude);
}


Future<Position> getLocation() async {
  final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
  );
  if (position != null) {
    return position;
  }
  return await Geolocator.getLastKnownPosition();
}

Position getInitialPosition() {
  Position position;
  determinePosition().then((positionValue){
    final Position position = positionValue;
    return position;
  });
  return position;
}
