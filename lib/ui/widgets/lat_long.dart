//import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LatLng {
  final double lat;
  final double lon;
  final String name;
  final String img;

  LatLng(this.lat, this.lon, this.name, this.img);

  String get displayName {
    return name
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

List<LatLng> stations = [
  LatLng(
    36.2953419,
    -115.1826146,
    'Aliante',
    'web/assets/dragon2.jpg',
  ),
  LatLng(
    36.3144897,
    -115.2033396,
    "Center", //'University of Nevada Coop Ext',
    'web/assets/center.jpg',
  ),
  LatLng(
    36.1484290,
    -115.3476993,
    'Red_Rock',
    'web/assets/red_rock.jpg',
  ),
  LatLng(
    36.1425838,
    -115.0548509,
    'Sunrise',
    'web/assets/dragon2.jpg',
  ),
  LatLng(
    36.0079534,
    -115.0448021,
    'Dragon_Ridge',
    'web/assets/dragon.jpg',
  )
];

Future<LatLng?> findClosestLocation(
    Position current, List<LatLng> locations) async {
  if (locations.isEmpty) return null;

  LatLng closest = locations.first;
  double minDistance = Geolocator.distanceBetween(
    current.latitude,
    current.longitude,
    closest.lat,
    closest.lon,
  );

  for (LatLng loc in locations) {
    double distance = Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      loc.lat,
      loc.lon,
    );

    if (distance < minDistance) {
      minDistance = distance;
      closest = loc;
    }
  }

  return closest;
}

// Future<Text> findClosestExample() async {
//   String closest = '';
//   Position current = await Geolocator.getCurrentPosition();

//   List<LatLng> stations = [
//     LatLng(36.29534198001432, -115.1826146288354, 'Aliante'),
//     LatLng(36.14842901158606, -115.34769938465836, 'Red Rock'),
//     LatLng(36.14258382556574, -115.05485095951873, 'Sunrise'),
//     LatLng(36.007953457846824, -115.04480218650625, 'Dragonridge')
//   ];

//   LatLng? nearest = await findClosestLocation(current, stations);

//   if (nearest != null) {
//     closest = 'Nearest location: ${nearest.name}';
//   }
//   return Text(
//     closest,
//     style: const TextStyle(fontSize: 18, color: Colors.black),
//   );
// }
