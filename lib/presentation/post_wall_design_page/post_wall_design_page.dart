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
