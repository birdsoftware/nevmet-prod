import 'package:nevmet/ui/common/app_colors.dart';
import 'package:nevmet/ui/common/app_constants.dart';
import 'package:nevmet/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:nevmet/ui/views/station_links.dart';
//import 'package:nevmet/ui/views/stations_view.dart';
import 'package:nevmet/ui/widgets/current_locaton_card.dart';
import 'package:nevmet/ui/widgets/footer_supporters.dart';
import 'package:nevmet/ui/widgets/horizontal_news.dart';
import 'package:nevmet/ui/widgets/iframescreen.dart';
import 'package:nevmet/ui/widgets/lat_long.dart';
import 'package:nevmet/ui/widgets/location_widget.dart';
import 'package:nevmet/ui/widgets/nav_bar.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class HomeViewDesktop extends ViewModelWidget<HomeViewModel> {
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'web/assets/background.jpg', // Replace with your uploaded image
            fit: BoxFit.cover,
          ),
        ),

        // Scrollable content
        SingleChildScrollView(
          child: Column(
            children: [
              NavBar(
                isHomePage: true,
              ),

              //const SizedBox(height: 12),

              const CurrentLocationCard(),

              const SizedBox(height: 12),

              const StationCardsList(),

              const SizedBox(height: 12),

              // Map card
              Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxWidth: 1000),
                child: const MapCard(),
              ),
              const SizedBox(height: 50),

              const HorizontalNewsScroll(),

              const SizedBox(height: 12),

              const FooterBar(),
            ],
          ),
        ),
      ],
    );
  }
}

class MapCard extends StatelessWidget {
  const MapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ET Station Locations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Iframescreen(),
            ),
          ],
        ),
      ),
    );
  }
}

// Register iframe view on web
class IFrameRegister {
  static bool _registered = false;

  static void register() {
    if (_registered) return;
    _registered = true;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'map-iframe',
      (int viewId) => html.IFrameElement()
        ..src =
            'https://www.google.com/maps/d/embed?mid=1j4umU__ajTXQf6Pn9HXUu2lsQ27g69g&ehbc=2E312F&noprof=1'
        ..style.border = '0'
        ..width = '640'
        ..height = '480',
    );
  }
}

class StationCardsList extends StatelessWidget {
  const StationCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                    MaterialPageRoute(
                      builder: (_) => StationLinksPage(center: station.name),
                    ),
                  );
                },
                child: Card(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image + gradient overlay
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
                                  Colors.black87,
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
                                  Shadow(blurRadius: 4, color: Colors.black)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lat: ${station.lat}, Lon: ${station.lon}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.bar_chart, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'View Reports',
                                  style: TextStyle(color: Colors.white),
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
    );
  }
}
