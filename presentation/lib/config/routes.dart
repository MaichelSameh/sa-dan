import 'package:flutter/material.dart';

import '../screens/screens.dart';

Map<String, Widget Function(BuildContext)> router =
    <String, Widget Function(BuildContext)>{
  SplashScreen.route_name: (_) =>
      const SplashScreen(key: Key(SplashScreen.route_name)),
};
