import 'package:flutter/material.dart';
import 'package:safedrive/screens/Home.dart';

class TipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
        backgroundColor:
            Color.fromARGB(255, 126, 126, 126), // Updated app bar color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 126, 126, 126), // Set background color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Maintenance Tips'),
              SizedBox(height: 16),
              TipCard(
                title: 'Regular Vehicle Maintenance',
                content:
                    'Regularly perform maintenance tasks such as oil changes, tire rotations, and brake inspections to ensure optimal vehicle performance and safety.',
              ),
              TipCard(
                title: 'Checking Fluid Levels',
                content:
                    'Check fluid levels such as oil, coolant, and brake fluid regularly. Top them up or replace them according to manufacturer recommendations to prevent engine damage and brake failure.',
              ),
              TipCard(
                title: 'Part Replacement Guidelines',
                content:
                    'Learn to identify signs of wear and tear in vehicle parts like brakes, tires, and filters. Replace them promptly to avoid mechanical failures and accidents.',
              ),
              TipCard(
                title: 'Using Genuine Parts',
                content:
                    'Always use genuine parts and verify their authenticity. Genuine parts ensure compatibility, performance, and longevity, preserving your vehicle\'s value and safety.',
              ),
              SectionTitle(title: 'Safe Driving Practices'),
              SizedBox(height: 16),
              TipCard(
                title: 'Maintaining Tire Pressure',
                content:
                    'Maintain proper tire pressure as per manufacturer specifications. Incorrect tire pressure affects handling, fuel efficiency, and tire lifespan.',
              ),
              TipCard(
                title: 'Avoiding Distracted Driving',
                content:
                    'Stay focused while driving to prevent accidents. Avoid distractions like texting, talking on the phone, or adjusting controls while on the road.',
              ),
              TipCard(
                title: 'Using the Safe Drive App',
                content:
                    'Utilize Safe Drive\'s features for adding and tracking parts, uploading images, communicating with suppliers, and accessing documentation and support. Maximize efficiency and convenience.',
              ),
              TipCard(
                title: 'Troubleshooting Tips',
                content:
                    'Refer to troubleshooting tips within Safe Drive if you encounter issues. Follow guidelines to resolve common problems and optimize app usage.',
              ),
              SectionTitle(title: 'Emergency Preparedness'),
              SizedBox(height: 16),
              TipCard(
                title: 'Handling Emergencies',
                content:
                    'Be prepared for emergencies like breakdowns or accidents. Have emergency contacts, roadside assistance information, and safety essentials ready in your vehicle.',
              ),
              TipCard(
                title: 'Emergency Contacts',
                content:
                    'Store emergency contacts in your phone and vehicle for quick access during emergencies. Include numbers for roadside assistance, towing services, and local authorities.',
              ),
              SectionTitle(title: 'Seasonal Maintenance Tips'),
              SizedBox(height: 16),
              TipCard(
                title: 'Seasonal Maintenance Recommendations',
                content:
                    'Adapt your vehicle maintenance for different seasons. Follow winterization tips for cold climates and summer driving tips for hot weather to ensure optimal performance and safety.',
              ),
              TipCard(
                title: 'Checking HVAC Systems',
                content:
                    'Regularly check and maintain HVAC systems, batteries, and other components affected by seasonal changes. Ensure comfort and reliability throughout the year.',
              ),
              SectionTitle(title: 'FAQs and Resources'),
              SizedBox(height: 16),
              TipCard(
                title: 'Frequently Asked Questions',
                content:
                    'Explore FAQs related to vehicle maintenance, spare parts, and Safe Drive app usage. Get answers to common queries and enhance your understanding.',
              ),
              TipCard(
                title: 'Additional Resources',
                content:
                    'Access additional resources such as user manuals, instructional videos, and reputable automotive websites for detailed information and expert guidance.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Updated text color
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String title;
  final String content;

  const TipCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color:
          Color.fromARGB(255, 204, 204, 204), // Updated card background color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
