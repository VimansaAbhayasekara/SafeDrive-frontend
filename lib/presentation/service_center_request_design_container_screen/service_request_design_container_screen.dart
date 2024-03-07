
import 'package:safedrive/widgets/service_request_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:safedrive/core/app_export.dart';

import '../service_request_design_page/service_request_design_page.dart';

// ignore_for_file: must_be_immutable
class GalileoDesignContainerScreen extends StatelessWidget {
  GalileoDesignContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: ServiceRequestAppRoutes.galileoDesignPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: _buildBottomBar(context))));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return ServiceRequestAppRoutes.galileoDesignPage;
      case BottomBarEnum.Chat:
        return "/";
      case BottomBarEnum.Myrequests:
        return "/";
      case BottomBarEnum.Account:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case ServiceRequestAppRoutes.galileoDesignPage:
        return GalileoDesignPage();
      default:
        return DefaultWidget();
    }
  }
}
