// import 'package:flutter/material.dart';
// import 'package:safedrive/core/app_export.dart';
//
// // ignore: must_be_immutable
// class AppbarLeadingImage extends StatefulWidget {
//   AppbarLeadingImage({
//     Key? key,
//     this.imagePath,
//     this.margin,
//     this.onTap,
//   }) : super(
//           key: key,
//         );
//
//   String? imagePath;
//
//   EdgeInsetsGeometry? margin;
//
//   Function? onTap;
//
//   @override
//   State<AppbarLeadingImage> createState() => _AppbarLeadingImageState();
// }
//
// class _AppbarLeadingImageState extends State<AppbarLeadingImage> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         widget.onTap!.call();
//       },
//       child: Padding(
//         padding: widget.margin ?? EdgeInsets.zero,
//         child: CustomImageView(
//           imagePath: widget.imagePath,
//           height: 24.adaptSize,
//           width: 24.adaptSize,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

class AppbarLeadingImage extends StatelessWidget {
  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;

  const AppbarLeadingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: imagePath != null
            ? CustomImageView(
          imagePath: imagePath!,
          height: 24.adaptSize,
          width: 24.adaptSize,
          fit: BoxFit.contain,
        )
            : SizedBox(), // Fallback widget if imagePath is null
      ),
    );
  }
}

