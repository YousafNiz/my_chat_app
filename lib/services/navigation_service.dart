import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  Future<Object?>? navigatorToReplacement(String _routeName) {
    return navigatorKey.currentState
        ?.pushReplacement(_routeName as Route<Object>);
  }

  Future<Object?>? navigatorTo(String _routeName) {
    return navigatorKey.currentState?.pushNamed(_routeName);
  }

  Future<Object?>? navigatorToRoute(MaterialPageRoute _route) {
    return navigatorKey.currentState?.push(_route as Route<Object>);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
