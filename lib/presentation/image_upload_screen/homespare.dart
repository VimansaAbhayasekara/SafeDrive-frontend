import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:safedrive/firebase_options.dart';
import 'imageupload.dart';
import '../about_us_screen/aboutuspg.dart';
import '../help_support_screen/help&supp.dart';
import 'previouspost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homespare()), // use MaterialApp
  );
}

class homespare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 62, 70, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text('Spare Parts Center'),
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
      body: Column(
        children: [
          // Add the image here
          Image.asset(
            'assets/images/back.png',
            width: double.infinity, // Make image take full width
            fit: BoxFit.cover, // Adjust image size to cover the space
          ),
          const SizedBox(
              height: 40), // Adding some space between the image and buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*  Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUsPage()),
                          );
                        },
                        child: const Text('About Us'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 41),
                          minimumSize: const Size(250, 70),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpSupPage()),
                          );
                        },
                        child: Text('Help & Support'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 41),
                          minimumSize: const Size(250, 70),
                        ),
                      ),
                    ),
                  ],
                ),                 */
                SizedBox(height: 105), // Adding some space between the rows
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        child: const Text('Add a New Post'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 41),
                          minimumSize: const Size(250, 70),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrePost()),
                          );
                        },
                        child: const Text('Previous Posts'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 42, 41),
                          minimumSize: const Size(250, 70),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.grey,
        tabs: [
          GButton(
            onPressed: () {},
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            onPressed: () {},
            icon: Icons.email,
            text: 'Email',
          ),
          GButton(
            onPressed: () {},
            icon: Icons.notifications,
            text: 'Notifications',
          ),
          GButton(
            onPressed: () {},
            icon: Icons.account_circle_rounded,
            text: 'Profile',
          )
        ],
      ),
    );
  }
}
