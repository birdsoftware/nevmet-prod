import 'package:flutter/material.dart';
import 'package:nevmet/ui/widgets/news_card.dart';

class HorizontalNewsScroll extends StatelessWidget {
  const HorizontalNewsScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rssFeeds = [
      {
        'title': 'BBC Environment',
        'logoAsset': 'web/assets/BBC.png',
        'url':
            'https://api.allorigins.win/raw?url=https://feeds.bbci.co.uk/news/science_and_environment/rss.xml',
      },
      {
        'title': 'Phys.org - Earth/Climate',
        'logoAsset': 'web/assets/PHYSORG.png',
        'url':
            'https://api.allorigins.win/raw?url=https://phys.org/rss-feed/breaking/earth-news/',
      },
      {
        'title': 'SciTechDaily - Earth & Climate',
        'logoAsset': 'web/assets/scitechdaily.jpg',
        'url':
            'https://api.allorigins.win/raw?url=https://scitechdaily.com/news/earth/feed/',
      },
      {
        'title': 'Science Daily',
        'logoAsset': 'web/assets/sd.png',
        'url':
            'https://api.allorigins.win/raw?url=https://www.sciencedaily.com/rss/top/environment.xml',
      },
    ];

    final cards = rssFeeds.map((feed) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 400,
          child: NewsCard(
            rssUrl: feed['url']!,
            logoAsset: feed['logoAsset']!,
          ),
        ),
      );
    }).toList();

    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: cards,
      ),
    );
  }
}
