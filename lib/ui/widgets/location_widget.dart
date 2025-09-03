import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nevmet/ui/widgets/lat_long.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String location = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check location services
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        location = 'Location services are disabled.';
      });
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          location = 'Location permission denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        location = 'Location permission permanently denied.';
      });
      return;
    }

    // Get location
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // List<LatLng> stations = [
    //   LatLng(36.29534198001432, -115.1826146288354, 'Aliante ET Station'),
    //   LatLng(36.14842901158606, -115.34769938465836, 'Red Rock ET Station'),
    //   LatLng(36.14258382556574, -115.05485095951873, 'Sunrise ET Station'),
    //   LatLng(36.007953457846824, -115.04480218650625, 'Dragonridge ET Station')
    // ];
    String closestName = '';
    LatLng? nearest = await findClosestLocation(pos, stations);

    if (nearest != null) {
      closestName = nearest.displayName;
    }

    setState(() {
      location = closestName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      location,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}
