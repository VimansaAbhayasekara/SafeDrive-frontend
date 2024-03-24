import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:safedrive/configuration/config.dart';
import 'package:safedrive/presentation/make_request_design_screen/serviceCenterNames.dart';
import 'package:safedrive/presentation/make_request_design_screen/vehicleMake.dart';
import 'package:safedrive/services/services.dart';
import 'package:safedrive/widgets/custom_textfield.dart';
import 'package:safedrive/widgets/date_time_picker.dart';
import 'package:safedrive/widgets/make_request_app_bar/custom_app_bar.dart';
import 'package:safedrive/widgets/make_request_app_bar/appbar_trailing_image.dart';
import 'package:safedrive/widgets/make_request_drop_down.dart';
import 'package:safedrive/widgets/make_request_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safedrive/services/token_service.dart';



class MakeRequestDesignScreen extends StatefulWidget {


  MakeRequestDesignScreen({Key? key}) : super(key: key,);

  @override
  State<MakeRequestDesignScreen> createState() => _MakeRequestDesignScreenState();
}

class _MakeRequestDesignScreenState extends State<MakeRequestDesignScreen> {


  List<VehicleMake> vehicleMakes = [];
  String? selectedVehicleMake;

  String? _selectedServiceCenter; // Initial value
  List<ServiceCenterNames> _serviceRequestNames = [];

  List<String> specificServiceItemList = [
    "Oil Change",
    "Wheel Alignment",
    "Brake Inspection and Service",
    "Air Filter Replacement",
    "Coolant Flush and Fill",
    "Transmission Fluid Change",
    "Battery Service",
    "Spark Plug Replacement",
    "Fluid Checks"
  ];

  List<String> timeSlotList = [
    "8am - 9am",
    "9am - 10am",
    "10am - 11am",
    "11am - 12am",
    "12am - 1pm",
    "1pm - 2pm",
    "2pm - 3pm",
    "3pm - 4pm",
    "4pm - 5pm",

  ];

  TextEditingController _vehicleMake = TextEditingController();

  TextEditingController _vehicleModel = TextEditingController();

  TextEditingController _serviceCenter = TextEditingController();

  TextEditingController _specificServices = TextEditingController();

  TextEditingController _dateTime = TextEditingController();

  TextEditingController _timeSlot = TextEditingController();

  List? items;

  void initState() {
    // TODO: implement initState
    super.initState();


    fetchVehicleMakeNames();
    addServiceRequest();
    _fetchServiceRequestNames();

  }


  @override
  Widget build(BuildContext context) {

    DateTime selectedDate = DateTime.now();
    return Sizer(builder: (context, orientation, deviceType)
    {
      return SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 18.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Request Service",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Vehicle Make",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTick,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select vehicle make",
                      alignment: Alignment.center,
                      items: vehicleMakes.map((make) => make.vehicleMakeName)
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _vehicleMake.text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Vehicle Model",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 9.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: CustomTextField(
                      controller: _vehicleModel,
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                        child: CustomTextField(
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select vehicle model",
                      alignment: Alignment.center,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Service Center",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 9.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTick,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select service center",
                      alignment: Alignment.center,
                      items: _serviceRequestNames.map((make) => make.serviceCenterNames)
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _serviceCenter.text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 27.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Specific Service",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTick,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select specific service",
                      alignment: Alignment.center,
                      items: specificServiceItemList,
                      onChanged: (value) {
                        setState(() {
                          _specificServices.text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Date ",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 9.v),


                  _buildDepthFrameZero(context, selectedDate),
                  SizedBox(height: 27.v),
                  Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Time Slot",
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTick,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select Time Slot",
                      alignment: Alignment.center,
                      items: timeSlotList,
                      onChanged: (value) {
                        setState(() {
                          _timeSlot.text = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 26.v),

                  _buildDepthFrameZero1(context),
                  SizedBox(height: 12.v),
                  Container(
                    height: 20.v,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: appTheme.gray50,
                    ),
                  ),
                  SizedBox(height: 5.v),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgCross,
          margin: EdgeInsets.fromLTRB(16.h, 16.v, 16.h, 8.v),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildDepthFrameZero(dateTimePickerKey, selectedDate) {
    GlobalKey dateTimePickerKey = GlobalKey();
    return Align(
      alignment: Alignment.center,
      child: DateTimePickerWidget(
        selectedDate: selectedDate,
        key: dateTimePickerKey,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            selectedDate = newDateTime;
            _dateTime.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          });
        },
      ),
    );
  }

  // final dio = new Dio();


  void addServiceRequest() async {

    // Call getUserDetails() to get user details
    Map<String, dynamic>? userDetails = await TokenService().getUserDetails();

    if (userDetails == null) {
      print('Failed to get user details');
      _showSuccessDialog("Failed to get user details");

      return;
    }

    // Extract email from user details
    String? userEmail = userDetails['email'] as String?;

    if (userEmail == null) {
      print('User email not found');
      _showSuccessDialog("User email not found");
      return;
    }

    final String url = 'https://serverbackend-w5ny.onrender.com/servicerequest';

    Map<String, dynamic> requestData = {
      "vehicleMake": _vehicleMake.text,
      "vehicleModel": _vehicleModel.text,
      "serviceCenter": _serviceCenter.text,
      "specificServices": _specificServices.text,
      "dateTime": _dateTime.text,
      "timeSlot": _timeSlot.text,
      "userEmail": userEmail,
      "status" : "pending"
    };

    // Encode the request body
    String requestBody = jsonEncode(requestData);

    // Set up headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      // Make POST request
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody,
      );

      // Check status code for success (2xx) or failure (4xx or 5xx)
      if (response.statusCode == 200) {
        print('Request posted successfully');
        print('Response: ${response.body}');
        _showSuccessDialog("Request submitted successfully");
      } else {
        print('Failed to post request. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
        _showSuccessDialog("Failed to submit request");
      }
    } catch (e) {
      print('Exception thrown: $e');
      _showSuccessDialog("Error: $e");
    }
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
                Navigator.pop(context); // Go back to the previous screen (ServiceRequestApprovalScreen)
              },
              child: Text("Okay"),
            ),
          ],
        );
      },
    );
  }

  // Get Vehicle make names

  Future<void> fetchVehicleMakeNames() async {

    final String url = 'https://serverbackend-w5ny.onrender.com/vehiclemake';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      setState(() {
        vehicleMakes.clear();
        vehicleMakes = jsonData.map((json) => VehicleMake.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _fetchServiceRequestNames() async {
    try {
      final String url = 'https://serverbackend-w5ny.onrender.com/profiledetails';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        setState(() {
          _serviceRequestNames.clear();
          // Assuming the service request names are stored in a key named 'names' in the response data
          List<dynamic> serviceNames = responseData['names'];
          _serviceRequestNames = serviceNames.map((name) => ServiceCenterNames.fromJson({'names': name})).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error: $e");
    }
  }


//Section Widget
  Widget _buildDepthFrameZero1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: CustomElevatedButton(
              width: double.infinity, // Adjusted width to fill available space
              text: "Cancel",
              onPressed: () {
                // Navigate back to Home() screen when cancel button is pressed
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(width: 10.h), // Added some spacing between the buttons
          Flexible(
            flex: 1,
            child: CustomElevatedButton(
              width: double.infinity, // Adjusted width to fill available space
              text: "Request",
              buttonStyle: CustomButtonStyles.fillBlue,
              buttonTextStyle: theme.textTheme.titleSmall!,
              onPressed: () {
                // Implement the action you want to take when the button is pressed
                addServiceRequest();

                // You can replace the print statement with any action you desire.
              },
            ),
          ),
        ],
      ),
    );
  }

}
