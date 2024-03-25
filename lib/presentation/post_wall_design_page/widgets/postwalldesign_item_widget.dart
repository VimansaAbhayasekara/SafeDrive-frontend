import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_wall_design_page.dart';

// ignore: must_be_immutable
class PostwalldesignItemWidget extends StatefulWidget {
  final ImageData imageData;

  const PostwalldesignItemWidget({Key? key, required this.imageData})
      : super(key: key);

  @override
  State<PostwalldesignItemWidget> createState() => _PostwalldesignItemWidgetState();
}

class _PostwalldesignItemWidgetState extends State<PostwalldesignItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: appTheme.gray50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Container(
        height: 500.v, // Adjusted height
        width: 358.h,
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CustomImageView(
              imagePath: widget.imageData.imageID, // Use imageID from ImageData
              height: 500.v, // Adjusted height
              width: 358.h,
              radius: BorderRadius.circular(
                12.h,
              ),
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.h,
                right: 16.h,
                bottom: 16.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Manufactured year: ",
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.imageData.manufacturedYear, // Use Firebase data
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: 2), // Add spacing between texts
                  Row(
                    children: [
                      Text(
                        "Spare part name: ",
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.imageData.sparePartName, // Use Firebase data
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: 2), // Add spacing between texts
                  Row(
                    children: [
                      Text(
                        "Vehicle color: ",
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.imageData.vehicleColour, // Use Firebase data
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: 2), // Add spacing between texts
                  Row(
                    children: [
                      Text(
                        "Vehicle make: ",
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.imageData.vehicleMake, // Use Firebase data
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: 2), // Add spacing between texts
                  Row(
                    children: [
                      Text(
                        "Vehicle model: ",
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        widget.imageData.vehicleModel, // Use Firebase data
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  /// Section Widget
  Widget _buildPostWallDesign(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('imageData').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while data is being fetched
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 32.v,
                );
              },
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Convert Firestore document data to ImageData object
                ImageData imageData = ImageData(
                  imageID: snapshot.data!.docs[index]['imageID'],
                  manufacturedYear: snapshot.data!.docs[index]['manufacturedYear']??'', // String
                  sparePartName: snapshot.data!.docs[index]['sparePartName'],
                  vehicleColour: snapshot.data!.docs[index]['vehicleColour'],
                  vehicleMake: snapshot.data!.docs[index]['vehicleMake'],
                  vehicleModel: snapshot.data!.docs[index]['vehicleModel'], );
                return PostwalldesignItemWidget(imageData: imageData);
              },
            );
          }
          return Text('No data found'); // Handle no data case
        },
      ),
    );
  }



