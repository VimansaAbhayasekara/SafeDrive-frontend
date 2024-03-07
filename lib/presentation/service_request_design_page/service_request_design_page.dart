import 'widgets/service_request_design_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

// ignore_for_file: must_be_immutable
class GalileoDesignPage extends StatelessWidget {
  const GalileoDesignPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillWhiteA,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildDepthFrameZero(context),
                  _buildGalileoDesign(context),
                  SizedBox(height: 12.v),
                  Container(
                    height: 20.v,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDepthFrameZero(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100.h,
        vertical: 26.v,
      ),
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        children: [
          SizedBox(height: 8.v),
          Text(
            "Requests",
            style: CustomTextStyles.titleMediumBold,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGalileoDesign(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (
        context,
        index,
      ) {
        return SizedBox(
          height: 12.v,
        );
      },
      itemCount: 6,
      itemBuilder: (context, index) {
        return ServiceRequestDesignItemWidget();
      },
    );
  }
}

