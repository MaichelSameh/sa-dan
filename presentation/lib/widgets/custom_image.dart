import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain/http_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/dir.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  ///this property works only for SVG
  final Color? color;
  final bool? matchTextDirection;
  const CustomImage({
    Key? key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.matchTextDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith(Dir.image_path) ||
        imagePath.startsWith(Dir.logo_path)) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        matchTextDirection: matchTextDirection ?? false,
        errorBuilder: (_, __, ___) {
          return Image.asset(
            Dir.getImagePath("image-placeholder"),
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            matchTextDirection: matchTextDirection ?? false,
          );
        },
      );
    }
    if (imagePath.startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, __, ___) {
          return Image.asset(
            Dir.getImagePath("image-placeholder"),
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            matchTextDirection: matchTextDirection ?? false,
          );
        },
      );
    }
    if (imagePath.startsWith("/storage") || imagePath.startsWith("/assets")) {
      return CachedNetworkImage(
        imageUrl: HttpConfig.baseUrl + imagePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, __, ___) {
          return Image.asset(
            Dir.getImagePath("image-placeholder"),
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
            matchTextDirection: matchTextDirection ?? false,
          );
        },
      );
    }
    if (imagePath.startsWith(Dir.icon_path) ||
        imagePath.startsWith(Dir.illustration_path) ||
        imagePath.startsWith(Dir.emoji_path)) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        matchTextDirection: matchTextDirection ?? true,
        color: color,
      );
    }
    return Image.file(
      File(imagePath),
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Image.asset(
          Dir.getImagePath("image-placeholder"),
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          matchTextDirection: matchTextDirection ?? false,
        );
      },
    );
  }
}
