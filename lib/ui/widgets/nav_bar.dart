import 'package:flutter/material.dart';
import 'package:nevmet/ui/views/about_view.dart';
import 'package:nevmet/ui/views/contact_view.dart';
import 'package:nevmet/ui/views/home/home_view.desktop.dart';
import 'package:nevmet/ui/views/station_links.dart';
import 'package:nevmet/ui/views/stations_view.dart';

class NavBar extends StatelessWidget {
  bool isHomePage;
  NavBar({super.key, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final logoHeight = isMobile ? 30.0 : 40.0;

    // final bool isHomePage = ModalRoute.of(context)?.settings.name == '/' ||
    //     ModalRoute.of(context)?.settings.name == null;

    return Container(
      height: 80,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left-aligned logo and text
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset(
                  'web/assets/nevm_logo.png',
                  height: logoHeight,
                ),
              ],
            ),
          ),
          // Centered navigation links
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: isHomePage
                  ? [
                      const NavButton(
                        label: 'Stations',
                        destination: StationsView(), //StationLinksPage(),
                      ),
                      const SizedBox(width: 20),
                      NavButton(
                        label: 'Contact',
                        destination: ContactDirectoryPage(employees: employees),
                      ),
                      const SizedBox(width: 20),
                      const NavButton(
                        label: 'About',
                        destination: AboutPage(),
                      ),
                    ]
                  : [
                      const NavButton(label: 'Home', goHome: true),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final Widget? destination;
  final bool goHome;

  const NavButton({
    super.key,
    required this.label,
    this.destination,
    this.goHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (goHome) {
          Navigator.pop(context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (_) => const HomeView()),
          //   (route) => false,
          // );
        } else if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => destination!),
          );
        }
      },
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
