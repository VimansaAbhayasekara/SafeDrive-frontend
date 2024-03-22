


// import 'package:flutter/material.dart';
//
// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});
//
//
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Safe Drive App",
//       home: Scaffold(
//         backgroundColor: Colors.black54,
//
//         appBar: AppBar(
//           backgroundColor: Colors.black54,
//         ),
//
//         body: Column(
//           // mainAxisAlignment:MainAxisAlignment.spaceBetween ,
//           // profile pic view
//           children: [
//             Center(
//               child: ClipOval(
//                 child: Image.asset("assets/profileImg.jpg",height: 150, scale: 2, )
//             )
//             ),
//
//             const SizedBox(
//               height: 20,
//             ),
//
//             const Text(" Name ",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.w500)
//               ),
//
//             //profile Details
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                 height: 350,
//                 width: 360,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.blueGrey,
//
//                 ),
//
//                 child: const Padding(
//                   padding: EdgeInsets.all(15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         " Name ",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500
//                         ),
//                       ),
//                       Text(
//                         " Ammar Ahamed ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//                       SizedBox(
//                         height: 20,
//                       ),
//
//                       Text(
//                         " Email ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//                       Text(
//                         " amr2siji@gmail.com ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//                       SizedBox(
//                         height: 20,
//                       ),
//
//                       Text(
//                         " Mobile Number ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//
//                       Text(
//                         " 0768391956 ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//                       SizedBox(
//                         height: 20,
//                       ),
//
//                       Text(
//                         " Date of Birth ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//
//                       Text(
//                         " 2001.08.27 ",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ),
//
//
//             )
//
//           ],
//
//         ),
//       ),
//
//     );
//   }
// }


import 'package:flutter/material.dart';

// Import the class where getUserDetails() is defined
import '../services/token_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  // Define variables to hold user details
  String? name;
  String? email;
  String? mobileNumber;
  String? userRole;

  @override
  void initState() {
    super.initState();
    // Fetch user details when the widget initializes
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Fetch user details
      Map<String, dynamic>? userDetails = await TokenService().getUserDetails();
      if (userDetails != null) {
        // Update state with fetched data
        setState(() {
          name = userDetails['name']; // Replace 'name' with the actual key in userDetails
          email = userDetails['email']; // Replace 'email' with the actual key in userDetails
          mobileNumber = userDetails['mobile']; // Replace 'mobile' with the actual key in userDetails
          userRole = userDetails['role']; // Replace 'dateOfBirth' with the actual key in userDetails
        });
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safe Drive App",
      home: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black54,
        ),
        body: Column(
          children: [
            Center(
              child: ClipOval(
                child: Image.asset("assets/images/profileImg.jpg", height: 150, scale: 2),
              ),
            ),
            const SizedBox(height: 20),
            // Display fetched user details
            Text(
              "Name",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              name ?? "", // Display name, or an empty string if null
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "Email",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              email ?? "", // Display email, or an empty string if null
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "Mobile Number",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              mobileNumber ?? "", // Display mobile number, or an empty string if null
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "User Role",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              userRole ?? "", // Display date of birth, or an empty string if null
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage
void main() {
  runApp(ProfileView());
}

