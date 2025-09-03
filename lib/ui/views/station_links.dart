import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

const String baseUrl = 'https://nevmet.netlify.app/assets/';
//'http://localhost:56611/assets/';

class StationLinksPage extends StatefulWidget {
  final String? center;
  const StationLinksPage({super.key, this.center});

  @override
  State<StationLinksPage> createState() => _StationLinksPageState();
}

class _StationLinksPageState extends State<StationLinksPage> {
  List<_ReportLink> reportLinks = [];

  @override
  void initState() {
    super.initState();
    loadXmlData();
  }

  Future<void> loadXmlData() async {
    final xmlString = await rootBundle.loadString('web/assets/WebData.xml');
    final xmlDoc = XmlDocument.parse(xmlString);

    final reports = <_ReportLink>[];

    for (final station in xmlDoc.findAllElements('station')) {
      final stationName = station.getAttribute('name') ?? 'Unknown Station';

      // Skip station if filtering by center and it doesn't match
      if (widget.center != null && stationName != widget.center) continue;

      for (final report in station.findAllElements('report')) {
        final reportName = report.getAttribute('name') ?? 'Unnamed Report';
        final webPage = report.findElements('web_page').first.text;
        reports.add(_ReportLink(
          title: '$stationName - $reportName',
          url: webPage,
        ));
      }
    }

    setState(() {
      reportLinks = reports;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Station Reports')),
      body: ListView.builder(
        itemCount: reportLinks.length,
        itemBuilder: (context, index) {
          final link = reportLinks[index];
          return ListTile(
            title: Text(link.title),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              // Replace this with launch in browser or WebView
              //http://localhost:53838/assets/Aliante/ET107.jpg
              //Uri.parse( 'http://localhost:53838/assets/Aliante/NewBatch1%20Evapotranspiration.htm');
              //print('Open: ${link.url}');
              final fullUrl = '$baseUrl${Uri.encodeFull(link.url)}';
              final uri = Uri.parse(fullUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Could not launch ${link.url}';
              }
            },
          );
        },
      ),
    );
  }
}

class _ReportLink {
  final String title;
  final String url;

  _ReportLink({required this.title, required this.url});
}
