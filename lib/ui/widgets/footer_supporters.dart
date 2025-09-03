import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterBar extends StatelessWidget {
  const FooterBar({super.key});

  final List<Map<String, String>> supporters = const [
    {
      'name': 'Red Rock Country Club',
      'url': 'http://www.redrockcountryclub.com/',
    },
    {
      'name': 'Dragon Ridge',
      'url': 'https://dragonridge.com/',
    },
    {
      'name': 'University of Nevada Cooperative Extension',
      'url': 'https://extension.unr.edu/master-gardeners/program.aspx?ID=13',
    },
    {
      'name': 'The Club at Sunrise',
      'url': 'http://www.theclubatsunrise.com',
    },
    {
      'name': 'Aliante Golf Course',
      'url': 'http://www.aliantegolf.com',
    },
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'We extend our sincere gratitude to the following supporters:',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 10,
            children: supporters.map((supporter) {
              return GestureDetector(
                onTap: () => _launchUrl(supporter['url']!),
                child: Text(
                  supporter['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
