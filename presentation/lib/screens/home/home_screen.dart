import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
            ),
          ),
          BottomNavBar(),
        ],
      ),
    );
  }
}
