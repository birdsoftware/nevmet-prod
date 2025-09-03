import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<Employee> employees = [
  const Employee(
    name: 'Dale Devitt',
    title: 'Soil and Water Professor',
    description:
        'Dale Devitt is a soil and water scientist specializing in soil-plant-water relationships in arid environments, '
        'with emphasis on irrigated systems using low-quality water. He leads the water component of the NSF EPSCoR climate change study '
        'at UNLV, overseeing advanced weather station transects in two Nevada mountain ranges. He also directs the Center for Urban Water '
        'Conservation, which conducts research on urban water issues. One current project explores the fate of pharmaceuticals in turfgrass '
        'irrigated with recycled water. Devitt earned his B.S., M.S., and Ph.D. in soil/environmental science from UC Riverside. He has authored '
        '72 peer-reviewed publications and a book. Outside of work, he supports homelessness organizations, makes wine, and enjoys the outdoors. '
        'Expertise: Water Management, Conservation, Quality, Salinity, Evapotranspiration, Climate Change, Biofuels Research Focus: Urban and '
        'ecosystem-level water use, including impacts of water diversion and climate change.',
    imageUrl: 'https://i.ibb.co/HTHpXcZx/Devitt-214x300.jpg',
    address:
        'Department of Life Sciences, 4505 S Maryland Pkwy, Las Vegas, NV 89154',
    email: 'dale.devitt@unlv.edu',
    phone: '+17028954699',
    linkedInUrl: 'https://www.unlv.edu/people/dale-devitt',
  ),
  const Employee(
    name: 'Brian Bird',
    title: 'Senior Software Engineer | Hydrologist',
    description:
        'Passionate about creating impactful applications and empowering others. Experienced in hydraulic analysis and modeling, as well as '
        'evapotranspiration data collection and modeling. Has authored or co-authered 15 publications, including a masters thesis'
        ' titled \'Temporal and Spatial Assessment of Evaporation, Transpiration, and Soil Moisture Redistribution.\'',
    imageUrl:
        'https://media.licdn.com/dms/image/v2/C5603AQHTMK1dNSbn8g/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1542953798638?e=2147483647&v=beta&t=oWu3FSDrqyvPyAXTP7SqrjZN7hlx-VQEHphKNDMVjKA',
    //address: '123 Innovation Way, Las Vegas, NV 89084',
    email: 'birdsoftware@gmail.com',
    //phone: '+17025551234',
    linkedInUrl: 'https://linkedin.com/in/brianmbird',
    additionalUrl: 'https://oasis.library.unlv.edu/thesesdissertations/832/',
  ),
  const Employee(
    name: 'Marilin Lopez-Bermudez',
    title: 'Greenhouse & Field Operations Manager',
    description: 'Leads Greenhouse & Field Operations.',
    imageUrl: 'https://i.ibb.co/zc40tPd/Marilin-Lopez-Bermudez.jpg',
    address: '4734 Horse Dr., North Las Vegas, NV 89084',
    email: 'marilin.lopez-bermudez@unlv.edu',
    phone: '+17027741444',
    linkedInUrl: 'https://www.instagram.com/center4urbanwaterconservation/',
  ),
  const Employee(
    name: 'Logan Love',
    title: 'Staff Research Associate III',
    description: 'Water conservation in the Mojave Desert.',
    imageUrl: 'https://i.ibb.co/rKbj31zz/9279571b577db216e56bc2dc4a30fb47.jpg',
    address: '8050 Paradise Road, Suite 100, Las Vegas, Nevada  89123',
    email: 'llove@unr.edu',
    //phone: '+17025551234',
    linkedInUrl: 'https://extension.unr.edu/profile.aspx?ID=1945',
  ),
];

class Employee {
  final String name;
  final String title;
  final String description;
  final String imageUrl;
  final String? address;
  final String email;
  final String? phone;
  final String linkedInUrl;
  final String? additionalUrl;

  const Employee({
    required this.name,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.address,
    required this.email,
    this.phone,
    required this.linkedInUrl,
    this.additionalUrl,
  });
}

class ContactDirectoryPage extends StatelessWidget {
  final List<Employee> employees;

  const ContactDirectoryPage({super.key, required this.employees});

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildEmployeeCard(BuildContext context, Employee employee) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(employee.imageUrl),
            ),
            const SizedBox(height: 12),
            Text(
              employee.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              employee.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              employee.description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            employee.address != null
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.location_on),
                    title: Text(employee.address ?? 'none'),
                  )
                : Container(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.email),
              title: Text(employee.email),
              onTap: () => _launchUrl('mailto:${employee.email}'),
            ),
            employee.phone != null
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.phone),
                    title: Text(employee.phone ?? 'none'),
                    onTap: () => _launchUrl('tel:${employee.phone}'),
                  )
                : Container(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.link),
              title: Text(employee.linkedInUrl),
              onTap: () => _launchUrl(employee.linkedInUrl),
            ),
            employee.additionalUrl != null
                ? ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.link),
                    title: Text(employee.additionalUrl ?? 'none'),
                    onTap: () => _launchUrl(employee.additionalUrl ?? '404'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet Our Team'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: employees.length,
        itemBuilder: (context, index) =>
            _buildEmployeeCard(context, employees[index]),
      ),
    );
  }
}
