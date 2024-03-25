import 'dart:convert';

import 'package:safedrive/presentation/service_request_design_page/widgets/serviceRequests.dart';
import 'package:safedrive/services/services.dart';
import 'package:safedrive/widgets/approve_request_app_bar/custom_app_bar.dart';
import 'package:safedrive/widgets/approve_request_app_bar/appbar_leading_image.dart';
import 'package:safedrive/widgets/approve_request_app_bar/appbar_title.dart';
import 'package:safedrive/widgets/approve_request_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';
import 'package:http/http.dart' as http;
import '../service_request_design_page/service_request_design_page.dart';

class ServiceRequestApprovalScreen extends StatefulWidget {

  final ServiceRequests serviceRequests;

  const ServiceRequestApprovalScreen({Key? key,required this.serviceRequests,
  })
      : super(
          key: key,
        );

  @override
  State<ServiceRequestApprovalScreen> createState() => _ServiceRequestApprovalScreenState();
}

class _ServiceRequestApprovalScreenState extends State<ServiceRequestApprovalScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                _buildProfileDetails(context),
                SizedBox(height: 22.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Requested service",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      widget.serviceRequests.specificServices,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),


                SizedBox(height: 20.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "When",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "${widget.serviceRequests.dateTime} , ${widget.serviceRequests.timeSlot}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),


                SizedBox(height: 20.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Vehicle Make & Model",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 32.v),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 4.v,
                    ),
                    decoration: AppDecoration.fillGray,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.v),
                        Text(
                          widget.serviceRequests.vehicleMake,
                          style: theme.textTheme.bodyLarge,
                        ),
                        SizedBox(height: 3.v),
                        Text(
                          widget.serviceRequests.vehicleModel,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30.v),
                _buildBottomButtons(context),
                // SizedBox(height: 12.v),
                _buildChat(context),

              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Section Widget

  PreferredSizeWidget _buildAppBar(BuildContext context) {

    return CustomAppBar(
      leadingWidth: 40.h,
      leading: GestureDetector(
        onTap: () {
          final imagePath = ImageConstant.backButtonIcon; // Provide a default image path if imagePath is null
          if (imagePath != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GalileoDesignPage()),
            );
          }
        },
        child: AppbarLeadingImage(
          imagePath: ImageConstant.backButtonIcon,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 28.v,
            bottom: 20.v,
          ),
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Service Request",
      ),
      styleType: Style.bgFill,
    );
  }


  /// Section Widget
  Widget _buildProfileDetails(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: TokenService().getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder while loading
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final userDetails = snapshot.data!;
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.fillGray,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.profilePic,
                  height: 100.adaptSize,
                  width: 100.adaptSize,
                  radius: BorderRadius.circular(
                    28.h,
                  ),
                  margin: EdgeInsets.only(bottom: 28.v),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.h,
                    top: 5.v,
                    bottom: 33.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userDetails['name'] ?? 'Name not found',
                        style: CustomTextStyles.titleMediumGray900,
                      ),
                      Text(
                        '${userDetails['province'] ?? 'Province not found'}, ${userDetails['district'] ?? 'District not found'}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('No data available'); // Placeholder for no data
        }
      },
    );
  }


  /// Section Widget
  Widget _buildBottomButtons(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: TokenService().getUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Placeholder while loading
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final userDetails = snapshot.data!;
          String userRole = userDetails['role'] ?? ''; // Get user's role

          // Check if the user's role is 'Service Center'
          if (userRole == 'Service Center') {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    width: 169.h,
                    text: "Decline",
                    margin: EdgeInsets.only(left: 11.h),
                    buttonStyle: CustomButtonStyles.fillBlue,
                    buttonTextStyle: theme.textTheme.titleMedium!,
                    onPressed: () {
                      // Call the function to update status here
                      deleteRequestDetails(widget.serviceRequests);
                    },
                  ),
                  CustomElevatedButton(
                    width: 169.h,
                    text: "Approve",
                    margin: EdgeInsets.only(left: 11.h),
                    buttonStyle: CustomButtonStyles.fillBlue,
                    buttonTextStyle: theme.textTheme.titleMedium!,
                    onPressed: () {
                      // Call the function to update status here
                      updateStatus(widget.serviceRequests);
                    },
                  ),
                ],
              ),
            );
          } else {
            // If the user's role is not 'Service Center', return an empty container
            return Container();
          }
        } else {
          return Text('No data available'); // Placeholder for no data
        }
      },
    );
  }

  /// Section Widget
  Widget _buildChat(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 152.h),
      decoration: AppDecoration.fillGray,
      child: Column(
        children: [
          SizedBox(height: 15.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Container(
              width: 38.h,
              padding: EdgeInsets.symmetric(vertical: 1.v),
              decoration: AppDecoration.fillBlueGray,
              child: Text(
                "Chat",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //approve button function

  void updateStatus(ServiceRequests requestData) {
    // Convert ServiceRequests instance to a map
    Map<String, dynamic> requestDataMap = {
      "vehicleMake": requestData.vehicleMake,
      "vehicleModel": requestData.vehicleModel,
      "serviceCenter": requestData.serviceCenter,
      "specificServices": requestData.specificServices,
      "dateTime": requestData.dateTime,
      "timeSlot": requestData.timeSlot,
      "status": "pending",
    };

    print(requestDataMap);

    const String backendUrl = 'https://serverbackend-w5ny.onrender.com/servicerequest';

    // Example using http package
    // Make sure to import the http package: import 'package:http/http.dart' as http;
    http.patch(Uri.parse(backendUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestDataMap), // Convert requestDataMap to JSON format
    ).then((response) {
      if (response.statusCode == 200) {
        // Status updated successfully
        print('Status updated successfully!');
        _showSuccessDialog("Request approved successfully!");
      } else {
        // Error occurred while updating status
        print('Failed to update status: ${response.statusCode}');
      }
    }).catchError((error) {
      // Error occurred during HTTP request
      print('Error updating status: $error');
    });
  }
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Navigator.pop(context); // Go back to the previous screen (ServiceRequestApprovalScreen)
              },
              child: Text("Okay"),
            ),
          ],
        );
      },
    );
  }

  // Function to send DELETE request to decline the service request
  void deleteRequestDetails(ServiceRequests requestData) {
    String url = 'https://serverbackend-w5ny.onrender.com/servicerequest'; // Replace with your actual endpoint

    Map<String, dynamic> requestBody = {
      'vehicleMake': requestData.vehicleMake,
      'vehicleModel': requestData.vehicleModel,
      'serviceCenter': requestData.serviceCenter,
      'specificServices': requestData.specificServices,
      'dateTime': requestData.dateTime,
      'timeSlot': requestData.timeSlot,
      'userEmail': requestData.userEmail,
      'status': requestData.status,
    };

    http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    ).then((response) {
      if (response.statusCode == 200) {
        print('Service request deleted successfully');
        _showSuccessDialog("Request deleted successfully!");
      } else {
        print('Error deleting service request: ${response.body}');
      }
    }).catchError((error) {
      print('Error deleting service request: $error');
    });
  }

}
