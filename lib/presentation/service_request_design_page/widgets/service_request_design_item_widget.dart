import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';
import 'package:safedrive/presentation/service_request_design_page/widgets/serviceRequests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../services/token_service.dart';
import '../../service_request_approval_design_screen/service_request_approval_design_screen.dart';

// ignore: must_be_immutable
class ServiceRequestDesignItemWidget extends StatefulWidget {
  const ServiceRequestDesignItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  State<ServiceRequestDesignItemWidget> createState() => _ServiceRequestDesignItemWidgetState();
}

class _ServiceRequestDesignItemWidgetState extends State<ServiceRequestDesignItemWidget> {
  List<ServiceRequests> serviceRequests = [];
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    fetchServiceRequests();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: serviceRequests.length,
        itemBuilder: (context, index) {
          ServiceRequests serviceRequest = serviceRequests[index];
          return GestureDetector(
            onTap: () {
              // Navigate to serviceRequestApprovalScreen with selected service request data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceRequestApprovalScreen(
                    serviceRequests: serviceRequests[index],
                  ),
                ),
              );
            },
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 12.v,
              ),
              decoration: AppDecoration.fillWhiteA,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgDepth3Frame0,
                    height: 72.v,
                    width: 115.h,
                    radius: BorderRadius.circular(
                      8.h,
                    ),
                    margin: EdgeInsets.only(bottom: 4.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.h,
                      bottom: 10.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceRequest.specificServices,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          "${serviceRequest.vehicleMake} ${serviceRequest.vehicleModel}",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 44.v),
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.h,
                      vertical: 5.v,
                    ),
                    decoration: AppDecoration.fillBlueGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                    ),
                    child: Container(
                      width: 85.h,
                      padding: EdgeInsets.symmetric(vertical: 1.v),
                      decoration: AppDecoration.fillBlueGray,
                      child: Text(
                        serviceRequest.dateTime,
                        style: CustomTextStyles.titleSmallGray900Medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchServiceRequests() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    final userDetails = await TokenService().getUserDetails();
    if (userDetails == null || userDetails['email'] == null) {
      setState(() {
        isError = true;
        isLoading = false;
      });
      return;
    }

    final String userEmail = userDetails['email'];

    final String url = 'https://serverbackend-w5ny.onrender.com/servicerequest';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print('All service requests: $jsonData');

        final List<ServiceRequests> filteredRequests = jsonData
            .map((json) => ServiceRequests.fromJson(json))
            .where((request) => request.userEmail == userEmail && request.status == "pending") // Add condition for pending status
            .toList();

        print('Filtered service requests: $filteredRequests');

        if (mounted) {
          setState(() {
            serviceRequests.clear();
            serviceRequests = filteredRequests;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching service requests: $e');
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

}

