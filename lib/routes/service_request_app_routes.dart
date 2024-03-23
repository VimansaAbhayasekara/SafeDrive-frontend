import 'package:flutter/material.dart';
import '../presentation/service_center_request_design_container_screen/service_request_design_container_screen.dart';
import '../presentation/service_center_request_navigation_screen/app_navigation_screen.dart';
import '../presentation/service_request_design_page/widgets/my_request_design_screen.dart';
import '../view/profile_view.dart';

class ServiceRequestAppRoutes {
  static const String galileoDesignPage = '/galileo_design_page';
  static const String myRequestDesignScreen = '/my_request_design_screen';
  static const String myProfileViewScreen = '/profile_view';

  static const String galileoDesignContainerScreen =
      '/galileo_design_container_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    galileoDesignContainerScreen: (context) => ServiceRequestDesignContainerScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen(),
    myRequestDesignScreen: (context) => MyRequestDesignScreen(),
    myProfileViewScreen: (context) => ProfileView(),
  };
}
