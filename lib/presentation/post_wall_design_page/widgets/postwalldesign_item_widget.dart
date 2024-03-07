import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

// ignore: must_be_immutable
class PostwalldesignItemWidget extends StatelessWidget {
  const PostwalldesignItemWidget({Key? key})
      : super(
          key: key,
        );

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
        height: 222.v,
        width: 358.h,
        decoration: AppDecoration.fillGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgDepth4Frame0,
              height: 222.v,
              width: 358.h,
              radius: BorderRadius.circular(
                12.h,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.h,
                  right: 126.h,
                  bottom: 16.v,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Brembo brake pads",
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(
                      "120",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
