import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nevmet/ui/widgets/location_widget.dart';

class CurrentLocationCard extends StatefulWidget {
  const CurrentLocationCard({super.key});

  @override
  State<CurrentLocationCard> createState() => _CurrentLocationCardState();
}

class _CurrentLocationCardState extends State<CurrentLocationCard> {
  String _locationText = 'Getting your location...';
  String _posText = '';
  //String _nearestStationName = '';
  //String _nearestStationCoords = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationText = 'Location services are disabled.';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationText = 'Location permission denied.';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationText = 'Permission permanently denied.';
        });
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _posText = 'Lat: ${pos.latitude}, Lon: ${pos.longitude}';

      //check if we have lt long data if we do get the nearest ET station and make a card for it in a row next to the current location card
      //LatLng? nearest = await findClosestLocation(pos, stations);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      Placemark place = placemarks[0];
      String name = place.name ?? '';
      String subLocality = place.subLocality ?? '';
      String locality = place.locality ?? '';
      String administrativeArea = place.administrativeArea ?? '';
      String postalCode = place.postalCode ?? '';
      String country = place.country ?? '';

      String address =
          "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

      setState(() {
        _locationText = "$address\n$_posText";
        // if (nearest != null) {
        //   _nearestStationName = nearest.name;
        //   _nearestStationCoords = 'Lat: ${nearest.lat}, Lon: ${nearest.lon}';
        // }
      });
    } catch (e) {
      setState(() {
        _locationText = _posText; //'Error getting location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;

        // Card width as a percentage of screen width
        final double cardWidth =
            isMobile ? constraints.maxWidth * 0.9 : constraints.maxWidth * 0.4;

        Widget buildCard(String title, Widget content) {
          return Container(
            width: cardWidth,
            margin: const EdgeInsets.all(12),
            child: Card(
              color: Colors.black.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    content,
                  ],
                ),
              ),
            ),
          );
        }

        final cards = [
          buildCard('Your Current Location',
              Text(_locationText, style: const TextStyle(color: Colors.white))),
          buildCard('Station nearest to your location', const LocationWidget()),
        ];

        return isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: cards,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards,
              );
      },
    );
  }
}
