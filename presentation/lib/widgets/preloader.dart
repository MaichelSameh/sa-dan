import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/palette.dart';

class Preloader extends StatelessWidget {
  const Preloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator(
              color: Palette.secondary_color,
            )
          : const CircularProgressIndicator(
              color: Palette.secondary_color,
            ),
    );
  }
}
