import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.onChange,
    this.border,
    this.controller,
    this.enabled = true,
    this.expanded = false,
    this.height,
    this.hint,
    this.label,
    this.hintStyle,
    this.keyboardType,
    this.obscureText = false,
    this.padding,
    this.radius,
    this.style,
    this.verticalAlign,
    this.width,
    this.validate,
    this.textInputAction,
    this.prefixWidget,
    this.color,
    this.shadow,
    this.focusNode,
    this.onSubmit,
    this.suffixIcon,
    this.textCapitalization,
  }) : super(key: key);

  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final BorderSide? border;
  final TextEditingController? controller;
  final bool enabled;
  final bool expanded;
  final double? height;
  final String? hint;
  final String? label;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? radius;
  final TextStyle? style;
  final TextAlignVertical? verticalAlign;
  final double? width;
  final String? Function(String?)? validate;
  final TextInputAction? textInputAction;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Color? color;
  final List<BoxShadow>? shadow;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? errorMessage;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context);
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: widget.height ?? size.height(mobile: 50),
              decoration: BoxDecoration(
                color: widget.color ?? const Color.fromRGBO(247, 248, 249, 1),
                borderRadius: widget.radius ??
                    BorderRadius.circular(size.width(mobile: 50)),
                boxShadow: widget.shadow,
              ),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        validator: (String? text) {
                          errorMessage = widget.validate?.call(text);
                          setState(() {});
                          return errorMessage?.isNotEmpty == true ? "" : null;
                        },
                        cursorColor: Palette.secondary_color,
                        controller: widget.controller,
                        textAlignVertical: widget.verticalAlign ??
                            (widget.expanded
                                ? TextAlignVertical.top
                                : TextAlignVertical.center),
                        maxLines: widget.expanded ? null : 1,
                        style: widget.style ??
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize! +
                                      2,
                                ),
                        expands: widget.expanded,
                        focusNode: widget.focusNode,
                        textCapitalization: widget.textCapitalization ??
                            TextCapitalization.none,
                        decoration: InputDecoration(
                          label: widget.label != null
                              ? Text(
                                  widget.label!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Colors.white.withOpacity(0.4)),
                                  textScaleFactor: 1,
                                )
                              : null,
                          contentPadding: widget.padding ??
                              EdgeInsets.symmetric(
                                  horizontal: size.width(mobile: 15),
                                  vertical: size.height(mobile: 14)),
                          hintText: widget.hint,
                          errorStyle: const TextStyle(fontSize: 0),
                          hintStyle: widget.hintStyle ??
                              Theme.of(context).textTheme.labelSmall,
                          border: OutlineInputBorder(
                            borderSide: widget.border ??
                                const BorderSide(color: Palette.primary_color),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: widget.border ??
                                const BorderSide(
                                    color: Color.fromRGBO(140, 31, 14, 1)),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: widget.border ??
                                const BorderSide(color: Palette.primary_color),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: widget.border ??
                                const BorderSide(color: Palette.primary_color),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: widget.border ??
                                const BorderSide(color: Palette.primary_color),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(140, 31, 14, 1)),
                            borderRadius: widget.radius ??
                                BorderRadius.circular(size.width(mobile: 50)),
                          ),
                          prefixIcon: widget.prefixWidget,
                          suffixIcon: widget.suffixIcon,
                        ),
                        textInputAction:
                            widget.textInputAction ?? TextInputAction.done,
                        onChanged: widget.onChange,
                        keyboardType: widget.keyboardType ?? TextInputType.name,
                        obscureText: widget.obscureText,
                        enabled: widget.enabled,
                        onFieldSubmitted: widget.onSubmit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (errorMessage?.isNotEmpty == true) ...<Widget>[
              SizedBox(height: size.height(mobile: 4)),
              Text(
                errorMessage!.tr,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: const Color.fromRGBO(140, 31, 14, 1)),
                textScaleFactor: 1,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
