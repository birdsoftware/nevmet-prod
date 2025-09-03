import 'package:flutter/material.dart';
import 'package:nevmet/ui/views/station_links.dart';
import 'package:nevmet/ui/widgets/nav_bar.dart';
import 'package:nevmet/ui/widgets/lat_long.dart'; // contains the stations list

class StationsView extends StatelessWidget {
  const StationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'web/assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          Column(
            children: [
              NavBar(),

              // List of Station Cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    final station = stations[index];

                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              //link
                              MaterialPageRoute(
                                builder: (_) =>
                                    StationLinksPage(center: station.name),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            clipBehavior: Clip
                                .antiAlias, // ensures image respects card border
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Station image
                                Stack(
                                  children: [
                                    Image.asset(
                                      station.img,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.transparent,
                                            Colors.black87, // Change as needed
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 8,
                                      left: 16,
                                      right: 16,
                                      child: Text(
                                        station.name == 'Center'
                                            ? 'University of Nevada Coop Ext'
                                            : station.displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 4,
                                                color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //title
                                      // Text(
                                      //   station.name == 'Center'
                                      //       ? 'University of Nevada Coop Ext'
                                      //       : station.displayName,
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //     fontSize: 20,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 8),
                                      //location
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lat: ${station.lat}, Lon: ${station.lon}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(Icons.bar_chart,
                                                  color: Colors.white),
                                              Text(
                                                'View Reports',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
