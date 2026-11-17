import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const aboutNavy = Color(0xFF163A5F);
const aboutSky = Color(0xFF3478A8);
const aboutGold = Color(0xFFEFCB70);
const aboutIvory = Color(0xFFF5F6F8);

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String githubUrl =
      'https://github.com/dvyah2903/excess-baggage-calculator';

  Future<void> _openGitHub(BuildContext context) async {
    final Uri url = Uri.parse(githubUrl);

    try {
      final bool opened = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open GitHub link.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aboutIvory,

      appBar: AppBar(
        title: const Text(
          'About Application',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: aboutNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),

            // APPLICATION ICON
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: aboutNavy,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: aboutNavy.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.luggage, color: aboutGold, size: 68),
            ),

            const SizedBox(height: 20),

            const Text(
              'Excess Baggage Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: aboutNavy,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Mobile Technology Application',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 32),

            // AUTHOR INFORMATION
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Author Information',
                style: TextStyle(
                  color: aboutNavy,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _infoTile(Icons.person, 'Name', 'NURHIDAYAH BINTI SAZILI'),

            _infoTile(Icons.badge, 'Matric Number', '2024214914'),

            _infoTile(Icons.school, 'Course', 'CDCS251'),

            const SizedBox(height: 25),

            // SOURCE CODE
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Source Code',
                style: TextStyle(
                  color: aboutNavy,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Color(0xFFE0E4EA)),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: const CircleAvatar(
                  backgroundColor: aboutIvory,
                  child: Icon(Icons.code, color: aboutNavy),
                ),
                title: const Text(
                  'GitHub Repository',
                  style: TextStyle(
                    color: aboutNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('View application source code'),
                trailing: const Icon(Icons.open_in_new, color: aboutSky),
                onTap: () async {
                  if (githubUrl.contains('your-username')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'GitHub link will be updated after repository creation.',
                        ),
                      ),
                    );
                    return;
                  }

                  await _openGitHub(context);
                },
              ),
            ),

            const SizedBox(height: 30),

            // COPYRIGHT NOTICE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: aboutNavy,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Icon(Icons.luggage, color: aboutGold, size: 28),
                  SizedBox(height: 10),
                  Text(
                    '© 2026 Excess Baggage Calculator',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'All Rights Reserved.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // AUTHOR INFORMATION CARD
  Widget _infoTile(IconData icon, String title, String value) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 11),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE0E4EA)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: aboutIvory,
          child: Icon(icon, color: aboutSky),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: aboutNavy,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
