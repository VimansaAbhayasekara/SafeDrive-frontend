import 'widgets/postwalldesign_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

// ignore_for_file: must_be_immutable
class PostWallDesignPage extends StatefulWidget {
  const PostWallDesignPage({Key? key})
      : super(
          key: key,
        );

  @override
  PostWallDesignPageState createState() => PostWallDesignPageState();
}

class PostWallDesignPageState extends State<PostWallDesignPage>
    with AutomaticKeepAliveClientMixin<PostWallDesignPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 28.v),
                Column(
                  children: [
                    _buildPostWallDesign(context),
                    SizedBox(height: 91.v),
                    Container(
                      height: 20.v,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: appTheme.gray50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPostWallDesign(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 32.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return const PostwalldesignItemWidget();
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:safedrive/core/app_export.dart';
//
// // Define a model class to represent the data
// class ImageData {
//   final String imageID;
//   final int manufacturedYear;
//   final String sparePartName;
//   final String vehicleColour;
//   final String vehicleMake;
//   final String vehicleModel;
//
//   ImageData({
//     required this.imageID,
//     required this.manufacturedYear,
//     required this.sparePartName,
//     required this.vehicleColour,
//     required this.vehicleMake,
//     required this.vehicleModel,
//   });
// }
//
// // ignore: must_be_immutable
// class PostwalldesignItemWidget extends StatelessWidget {
//   final ImageData imageData;
//
//   const PostwalldesignItemWidget({
//     Key? key,
//     required this.imageData,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 0,
//       margin: const EdgeInsets.all(0),
//       color: appTheme.gray50,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusStyle.roundedBorder12,
//       ),
//       child: Container(
//         height: 222.v,
//         width: 358.h,
//         decoration: AppDecoration.fillGray.copyWith(
//           borderRadius: BorderRadiusStyle.roundedBorder12,
//         ),
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             // Display Image from Firestore collection
//             CustomImageView(
//               imagePath: imageData.imageID, // Assuming imageID is the path to the image in Firestore Storage
//               height: 222.v,
//               width: 358.h,
//               radius: BorderRadius.circular(
//                 12.h,
//               ),
//               alignment: Alignment.center,
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: 16.h,
//                   right: 126.h,
//                   bottom: 16.v,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       imageData.sparePartName,
//                       style: theme.textTheme.headlineSmall,
//                     ),
//                     Text(
//                       imageData.manufacturedYear.toString(),
//                       style: theme.textTheme.titleMedium,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PostWallDesignPage extends StatefulWidget {
//   const PostWallDesignPage({Key? key}) : super(key: key);
//
//   @override
//   PostWallDesignPageState createState() => PostWallDesignPageState();
// }
//
// class PostWallDesignPageState extends State<PostWallDesignPage>
//     with AutomaticKeepAliveClientMixin<PostWallDesignPage> {
//   @override
//   bool get wantKeepAlive => true;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 28.v),
//                 Column(
//                   children: [
//                     _buildPostWallDesign(context),
//                     SizedBox(height: 91.v),
//                     Container(
//                       height: 20.v,
//                       width: double.maxFinite,
//                       decoration: BoxDecoration(
//                         color: appTheme.gray50,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Section Widget
//   Widget _buildPostWallDesign(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.h),
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('imageData').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Show loading indicator while data is being fetched
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (snapshot.hasData && snapshot.data != null) {
//             return ListView.separated(
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               separatorBuilder: (context, index) {
//                 return SizedBox(
//                   height: 32.v,
//                 );
//               },
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 // Convert Firestore document data to ImageData object
//                 ImageData imageData = ImageData(
//                   imageID: snapshot.data!.docs[index]['imageID'],
//                   manufacturedYear: snapshot.data!.docs[index]['manufacturedYear'],
//                   sparePartName: snapshot.data!.docs[index]['sparePartName'],
//                   vehicleColour: snapshot.data!.docs[index]['vehicleColour'],
//                   vehicleMake: snapshot.data!.docs[index]['vehicleMake'],
//                   vehicleModel: snapshot.data!.docs[index]['vehicleModel'],
//                 );
//                 return PostwalldesignItemWidget(imageData: imageData);
//               },
//             );
//           }
//           return Text('No data found'); // Handle no data case
//         },
//       ),
//     );
//   }
// }
