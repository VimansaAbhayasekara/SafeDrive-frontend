import 'package:safedrive/widgets/custom_search_view.dart';
import 'package:safedrive/presentation/post_wall_design_page/post_wall_design_page.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

// ignore_for_file: must_be_immutable
class PostWallDesignTabContainerPage extends StatefulWidget {
  const PostWallDesignTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  PostWallDesignTabContainerPageState createState() =>
      PostWallDesignTabContainerPageState();
}

class PostWallDesignTabContainerPageState
    extends State<PostWallDesignTabContainerPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  // late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    // tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGray,
            child: Column(
              children: [
                _buildDepthFrameZero(context),
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: CustomSearchView(
                    controller: searchController,
                    hintText: "Search for spare parts...",
                  ),
                ),
                SizedBox(height: 12.v),
                SizedBox(
                  height: 774.v,
                  child: PostWallDesignPage(),
                ),

                SizedBox(height: 12.v),

              ],
            ),
          ),
        ),
      ),
    );
  }




  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       body: Container(
  //         width: double.maxFinite,
  //         decoration: AppDecoration.fillGray,
  //         child: Column(
  //           children: [
  //             _buildDepthFrameZero(context),
  //             SizedBox(height: 12.v),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 16.h),
  //               child: CustomSearchView(
  //                 controller: searchController,
  //                 hintText: "Search for spare parts...",
  //               ),
  //             ),
  //             SizedBox(height: 12.v),
  //             // _buildTabview(context),
  //             SizedBox(
  //               height: 774.v,
  //               child: PostWallDesignPage(),
  //             ),
  //             // Expanded(
  //             //   child: SizedBox(
  //             //     height: 774.v,
  //             //     child: TabBarView(
  //             //       controller: tabviewController,
  //             //       children: const [
  //             //         PostWallDesignPage(),
  //             //         // PostWallDesignPage(),
  //             //       ],
  //             //     ),
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildDepthFrameZero(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 140.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray,
      child: Column(
        children: [
          SizedBox(height: 25.v),
          Text(
            "Spare Parts",
            style: CustomTextStyles.titleMediumGray900,
          ),
        ],
      ),
    );
  }

  // /// Section Widget
  // Widget _buildTabview(BuildContext context) {
  //   return Container(
  //     height: 54.v,
  //     width: double.maxFinite,
  //     decoration: BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           color: appTheme.blueGray100,
  //           width: 1.h,
  //         ),
  //       ),
  //     ),
  //     child: TabBar(
  //       controller: tabviewController,
  //       isScrollable: true,
  //       labelColor: appTheme.gray900,
  //       unselectedLabelColor: appTheme.blueGray500,
  //       tabs: const [
  //         Tab(
  //           child: Text(
  //             "Newest",
  //           ),
  //         ),
  //         Tab(
  //           child: Text(
  //             "Price",
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
