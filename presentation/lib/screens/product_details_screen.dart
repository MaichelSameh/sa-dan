import 'package:data/models/product_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String route_name = "product-details-screen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductInfo product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
