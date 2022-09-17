import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/config.dart';
import '../widgets.dart';
import 'sheet_layout.dart';

Future<File?> showImagePicker(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    builder: (_) => const SelectImageSheet(),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}

class SelectImageSheet extends StatefulWidget {
  const SelectImageSheet({Key? key}) : super(key: key);

  @override
  State<SelectImageSheet> createState() => _SelectImageSheetState();
}

class _SelectImageSheetState extends State<SelectImageSheet> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return SheetLayout(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width(mobile: 15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (ImageSource source in ImageSource.values)
              GestureDetector(
                onTap: () async {
                  PermissionStatus status = await Permission.camera.status;
                  if (status.isDenied) {
                    await Permission.camera.request();
                  }
                  XFile? image = await ImagePicker().pickImage(source: source);
                  Get.back(result: image == null ? null : File(image.path));
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: size.height(mobile: 10)),
                  child: Row(
                    children: <Widget>[
                      CustomImage(
                        imagePath: Dir.getIconPath(source.name),
                        color: Colors.black,
                        width: size.width(mobile: 20),
                      ),
                      SizedBox(width: size.width(mobile: 15)),
                      Text(
                        source.name.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textScaleFactor: 1,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: size.height(mobile: 10)),
          ],
        ),
      ),
    );
  }
}
