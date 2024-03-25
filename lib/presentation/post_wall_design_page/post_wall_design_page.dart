import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/postwalldesign_item_widget.dart';
import 'package:safedrive/core/app_export.dart';
import 'package:flutter/material.dart';

class ImageData {
  final String imageID;
  final String manufacturedYear;
  final String sparePartName;
  final String vehicleColour;
  final String vehicleMake;
  final String vehicleModel;

  ImageData({
    required this.imageID,
    required this.manufacturedYear,
    required this.sparePartName,
    required this.vehicleColour,
    required this.vehicleMake,
    required this.vehicleModel,
  });
}


class PostWallDesignPage extends StatefulWidget {
  const PostWallDesignPage({Key? key}) : super(key: key);

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
                _buildPostWallDesign(context), // Call _buildPostWallDesign here
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
                  manufacturedYear: snapshot.data!.docs[index]['manufacturedYear'] ?? '',
                  sparePartName: snapshot.data!.docs[index]['sparePartName'],
                  vehicleColour: snapshot.data!.docs[index]['vehicleColour'],
                  vehicleMake: snapshot.data!.docs[index]['vehicleMake'],
                  vehicleModel: snapshot.data!.docs[index]['vehicleModel'],
                );
                return PostwalldesignItemWidget(imageData: imageData);
              },
            );
          }
          return Text('No data found'); // Handle no data case
        },
      ),
    );
  }
}

