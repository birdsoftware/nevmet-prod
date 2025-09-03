import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart' as xml;

class NewsCard extends StatefulWidget {
  final String rssUrl;
  final String logoAsset;

  const NewsCard({super.key, required this.rssUrl, required this.logoAsset});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  List<Map<String, String>> newsItems = [];
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final response = await http.get(Uri.parse(widget.rssUrl));
      if (response.statusCode == 200) {
        final doc = xml.XmlDocument.parse(response.body);
        final items = doc.findAllElements('item').take(5);

        setState(() {
          _hasError = false;
          newsItems = items.map((item) {
            return {
              'title': item.getElement('title')?.text ?? 'No Title',
              'link': item.getElement('link')?.text ?? '',
            };
          }).toList();
        });
      } else {
        setState(() => _hasError = true);
      }
    } catch (e) {
      debugPrint('Failed to load RSS feed: $e');
      setState(() => _hasError = true);
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Card(
            color: Colors.black.withOpacity(0.6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset(
                    widget.logoAsset,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  // Text(
                  //   widget.title,
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _hasError
                        ? const Text(
                            'Oops—news hit snooze.',
                            style: TextStyle(color: Colors.redAccent),
                          )
                        : newsItems.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : ListView.builder(
                                itemCount: newsItems.length,
                                itemBuilder: (context, index) {
                                  final item = newsItems[index];
                                  return GestureDetector(
                                    onTap: () => _launchURL(item['link']!),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        '• ${item['title']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
