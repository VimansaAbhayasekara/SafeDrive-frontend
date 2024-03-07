import 'package:flutter/material.dart';
import 'package:safedrive/presentation/make_request_design_screen/make_request_design_screen.dart';

class MakeRequestAppRoutes {
  static const String makeRequestDesignScreen = '/galileo_design_screen';

  static Map<String, WidgetBuilder> routes = {
    makeRequestDesignScreen: (context) => MakeRequestDesignScreen()
  };
}
