import 'package:flutter/material.dart';
import 'package:nevmet/ui/widgets/nav_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text('About This Site'),
                        ),
                        SizedBox(height: 16),
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontSize: 16, height: 1.6),
                          child: Text(
                            'Welcome to the Nevada Evapotranspiration Monitoring and Education Tool — '
                            'a web app designed to support community engagement with local water use data and sustainability efforts across Southern Nevada.\n\n'
                            'This platform was created to help residents, researchers, and educators easily explore real-time and historical '
                            'evapotranspiration (ET) data from monitoring stations across the valley. Whether you’re managing your home irrigation, studying environmental change, '
                            'or simply curious about how water moves through our desert landscape — this site is here to connect you with the information that matters.',
                          ),
                        ),
                        SizedBox(height: 24),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(
                            'Backed by Science and Community',
                          ),
                        ),
                        SizedBox(height: 16),
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontSize: 16, height: 1.6),
                          child: Text(
                            'The data presented in this app is made possible through decades of research and outreach conducted at the '
                            'Center for Urban Water Conservation, located in North Las Vegas. Established in 1994, the Center is a unique partnership between UNLV, UNR, '
                            'and the City of North Las Vegas, focused on advancing water conservation through applied research, demonstration projects, and public education.\n\n'
                            'The Center’s 10-acre site hosts a range of critical infrastructure including orchards, turf and palm tree test plots, '
                            'weather and evapotranspiration monitoring, compost and mulch distribution, and education programs for the public and Master Gardeners.',
                          ),
                        ),
                        SizedBox(height: 24),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(
                            'Our Mission',
                          ),
                        ),
                        SizedBox(height: 16),
                        DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontSize: 16, height: 1.6),
                          child: Text(
                            'This system serves as a bridge between research and real life. By making environmental data accessible and understandable, we aim to:\n\n'
                            '• Support smarter water use decisions\n'
                            '• Raise awareness about evapotranspiration and climate\n'
                            '• Promote sustainability and conservation for all\n\n'
                            'Thank you for visiting and being part of a more water-wise Nevada.',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
