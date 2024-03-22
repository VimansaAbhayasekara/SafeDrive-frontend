import 'package:flutter/material.dart';
import '../presentation/service_Center_Request_design_container_screen/service_request_design_container_screen.dart';
import '../presentation/service_center_request_navigation_screen/app_navigation_screen.dart';

class ServiceRequestAppRoutes {
  static const String galileoDesignPage = '/galileo_design_page';

  static const String galileoDesignContainerScreen =
      '/galileo_design_container_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    galileoDesignContainerScreen: (context) => GalileoDesignContainerScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen()
  };
}
