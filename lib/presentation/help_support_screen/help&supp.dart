import 'package:flutter/material.dart';

class HelpSupPage extends StatelessWidget {
  const HelpSupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 62, 70, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Help & Support'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to Upload an Image:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'To upload an image, follow these steps:\n'
              '1. Tap on the "Add a New Post" button on the home screen.\n'
              '2. Fill in the necessary details such as title, description, etc.\n'
              '3. Tap on the image icon to select an image from your device.\n'
              '4. Choose the desired image from your gallery or camera.\n'
              '5. Once selected, the image will be uploaded with your post.',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              'How to Use the App:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Here are some tips on using the app:\n'
              '- Navigate through the different screens using the bottom navigation bar.\n'
              '- Use the "Add a New Post" button to create new posts.\n'
              '- Access the "Previous Posts" section to view your past posts.\n'
              '- Use the "Menu" button in the app bar for additional options.',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
