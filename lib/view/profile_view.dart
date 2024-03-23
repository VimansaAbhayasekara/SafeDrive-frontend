import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../services/token_service.dart';
import 'package:http/http.dart' as http;


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
  String? district;
  String? province;

  // Edit mode flag
  bool isEditMode = false;

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
          name = userDetails['name'];
          email = userDetails['email'];
          mobileNumber = userDetails['mobile'];
          userRole = userDetails['role'];
          district = userDetails['district']; // Fetch district
          province = userDetails['province']; // Fetch province
        });
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  // Function to handle edit button press
  void handleEditButtonPress() {
    setState(() {
      // Toggle edit mode
      isEditMode = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safe Drive App",
      home: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          backgroundColor: Colors.white60,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                "Profile View",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 25),
              Center(
                child: ClipOval(
                  child: Image.asset("assets/images/profileImg.jpg", height: 150, scale: 2),
                ),
              ),
              const SizedBox(height: 20),
              // Display fetched user details
              if (!isEditMode) ...[
                buildDetailItem("Name", name),
              ] else ...[
                buildEditableDetailItem("Name", name, (newValue) {
                  setState(() {
                    name = newValue;
                  });
                }),
              ],
              buildDetailItem("Email", email),
              if (!isEditMode) ...[
                buildDetailItem("Mobile Number", mobileNumber),
              ] else ...[
                buildEditableDetailItem("Mobile Number", mobileNumber, (newValue) {
                  setState(() {
                    mobileNumber = newValue;
                  });
                }),
              ],
              buildDetailItem("User Role", userRole),
              // Display district and province if not in edit mode
              if (!isEditMode) ...[
                buildDetailItem("District", district),
                buildDetailItem("Province", province),
              ] else ...[
                buildEditableDetailItem("District", district, (newValue) {
                  setState(() {
                    district = newValue;
                  });
                }),
                buildEditableDetailItem("Province", province, (newValue) {
                  setState(() {
                    province = newValue;
                  });
                }),
              ],
              const SizedBox(height: 5),
              // Display Edit or Save button based on edit mode
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: isEditMode
                    ? ElevatedButton(
                  onPressed: handleSaveButtonPress,
                  child: Text("Save"),
                )
                    : TextButton(
                  onPressed: handleEditButtonPress,
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display profile detail item
  Widget buildDetailItem(String title, String? value) {
    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          value ?? "",
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

// Widget to display editable profile detail item
  Widget buildEditableDetailItem(String title, String? value, void Function(String)? onChanged) {
    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        Center(
          child: TextFormField(
            initialValue: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Enter $title",
              // Align the text to the center
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            textAlign: TextAlign.center, // Center the entered text
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void handleSaveButtonPress() {

    updateUserProfile(email, name, mobileNumber, district, province);
    // After updating the profile, switch back to non-edit mode
    setState(() {
      isEditMode = false;
    });
  }

// Function to update user profile in the database
  void updateUserProfile(String? email, String? newName, String? newMobileNumber, String? newDistrict, String? newProvince) {
    String url = 'https://serverbackend-w5ny.onrender.com/profiledetails';

    Map<String, String> requestBody = {
      'email': email!,
      'newName': newName!,
      'newMobile': newMobileNumber!,
      'newDistrict': newDistrict!,
      'newProvince': newProvince!,
    };

    print('Sending JSON request: $requestBody');


    // Send a PATCH request to update the user profile
    http.patch(Uri.parse(url), body: requestBody)
        .then((response) {
      // Handle response
      if (response.statusCode == 200) {
        // Profile updated successfully
        print('Profile updated successfully');
      } else {
        // Handle error
        print('Error updating profile: ${response.body}');
      }
    })
        .catchError((error) {
      // Handle error
      print('Error updating profile: $error');
    });
  }

}

