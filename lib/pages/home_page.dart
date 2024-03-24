// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:safedrive/pages/chat_page.dart';
// import 'package:safedrive/services/auth/auth_service.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   //instance of auth
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   //sign user out
//   void signOut() {
//     final authService = Provider.of<AuthService>(context, listen: false);
//     authService.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Safe Drive'),
//           actions: [
//             //sign out button
//             IconButton(
//               onPressed: signOut,
//               icon: const Icon(Icons.logout),
//             )
//           ],
//         ),
//         body: _buildUserList());
//   }

//   //build a list of user except for the current logged in user
//   Widget _buildUserList() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('user').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Text('error');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Text('loading....');
//         }
//         return ListView(
//           children: snapshot.data!.docs
//               .map<Widget>((doc) => _buildUserListItem(doc))
//               .toList(),
//         );
//       },
//     );
//   }

//   Widget _buildUserListItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

//     //display all users except current user
//     if (_auth.currentUser!.email != data['email']) {
//       return ListTile(
//         title: Text(data['email']),
//         onTap: () {
//           //pass the clicked user's UID to the chat page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ChatPage(
//                 receiveruserEmail: data['email'],
//                 receiverUserID: data['uid'],
//               ),
//             ),
//           );
//         },
//       );
//     } else {
//       return Container();
//     }
//   }
// }

// home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/pages/chat_page.dart'; // Updated import

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe Drive Chat'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error fetching users');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            final userData = doc.data() as Map<String, dynamic>;
            final userEmail = userData['email'] as String;
            final userId = userData['uid'] as String;

            return ListTile(
              title: Text(userEmail),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiveruserEmail: userEmail,
                      receiverUserID: userId,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
