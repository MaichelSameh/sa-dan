import 'package:data/models/product_info.dart';
import 'package:domain/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../controllers/user_controller.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_handler.dart';
import '../../../widgets/preloader.dart';

class FavoriteButton extends StatefulWidget {
  final ProductInfo product;
  final void Function(ProductInfo) onChange;
  const FavoriteButton({
    Key? key,
    required this.product,
    required this.onChange,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isChanging = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size size = Size(context: context, constrain: constraints);
      return GestureDetector(
        onTap: () async {
          if (Get.find<UserController>().token == null || isChanging) {
            return;
          }
          isChanging = true;
          setState(() {});
          if (widget.product.isFavorite) {
            bool _ = await ProductServices()
                .unfavorite(
              id: widget.product.id,
              token: Get.find<UserController>().token!.token.combinedToken,
              lang: Get.locale?.languageCode,
            )
                .catchError((dynamic error) {
              isChanging = false;
              setState(() {});
              errorHandler(error);
            });
          } else {
            bool _ = await ProductServices()
                .favorite(
              id: widget.product.id,
              token: Get.find<UserController>().token!.token.combinedToken,
              lang: Get.locale?.languageCode,
            )
                .catchError((dynamic error) {
              isChanging = false;
              setState(() {});
              errorHandler(error);
            });
          }
          widget.onChange(
              widget.product.copyWith(isFavorite: !widget.product.isFavorite));
          isChanging = false;
          setState(() {});
        },
        child: Container(
          width: size.width(mobile: 36),
          height: size.width(mobile: 36),
          margin: EdgeInsetsDirectional.only(end: size.width(mobile: 22)),
          padding: EdgeInsets.all(size.width(mobile: 12)),
          decoration: BoxDecoration(
            color: widget.product.isFavorite
                ? Palette.red_color
                : Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 25,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: isChanging
              ? const Preloader()
              : CustomImage(
                  imagePath: Dir.getIconPath(
                      widget.product.isFavorite ? "love-solid" : "love")),
        ),
      );
    });
  }
}
