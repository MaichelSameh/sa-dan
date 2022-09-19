import 'package:data/models/models.dart';
import 'package:domain/services/services.dart';
import 'package:get/get.dart';

import '../widgets/error_handler.dart';
import 'controllers.dart';

class HomeController extends GetxController {
  List<BannerInfo> _banners = <BannerInfo>[];
  List<CategoryInfo> _categories = <CategoryInfo>[];
  List<ProductInfo> _topRatedProducts = <ProductInfo>[];
  List<ProductInfo> _mostSellingProducts = <ProductInfo>[];

  bool _isBannerLoaded = false;
  bool _isCategoriesLoaded = false;
  bool _isMostSellingProductLoaded = false;
  bool _isTopRatedProductsLoaded = false;

  List<BannerInfo> get banners => _banners;
  List<CategoryInfo> get categories => _categories;
  List<ProductInfo> get mostSellingProducts => _mostSellingProducts;
  List<ProductInfo> get topRatedProducts => _topRatedProducts;

  bool get isBannerLoaded => _isBannerLoaded;
  bool get isCategoriesLoaded => _isCategoriesLoaded;
  bool get isMostSellingProductsLoaded => _isMostSellingProductLoaded;
  bool get isTopRatedProductsLoaded => _isTopRatedProductsLoaded;

  Future<void> getBanners() async {
    _banners = await BannerServices()
        .getAll(
      lang: Get.locale?.languageCode,
      token: Get.find<UserController>().token?.token.combinedToken,
    )
        .catchError((dynamic error) {
      errorHandler(error);
      _isBannerLoaded = true;
      update();
    });
    _isBannerLoaded = true;
    update();
  }

  Future<void> getCategories() async {
    _categories = await CategoryServices()
        .getAll(
      lang: Get.locale?.languageCode,
      token: Get.find<UserController>().token?.token.combinedToken,
    )
        .catchError((dynamic error) {
      errorHandler(error);
      _isCategoriesLoaded = true;
      update();
    });
    _isCategoriesLoaded = true;
    update();
  }

  Future<void> getHighlyRatedProducts() async {
    if (isTopRatedProductsLoaded) {
      return;
    }
    _topRatedProducts = await ProductServices()
        .getTopRated(
      lang: Get.locale?.languageCode,
      token: Get.find<UserController>().token?.token.combinedToken,
    )
        .catchError((dynamic error) {
      errorHandler(error);
      _isTopRatedProductsLoaded = true;
      update();
    });
    _isTopRatedProductsLoaded = true;
    update();
  }

  Future<void> getMostSellingProducts() async {
    if (isMostSellingProductsLoaded) {
      return;
    }
    _mostSellingProducts = await ProductServices()
        .getTopSelling(
      lang: Get.locale?.languageCode,
      token: Get.find<UserController>().token?.token.combinedToken,
    )
        .catchError((dynamic error) {
      errorHandler(error);
      _isMostSellingProductLoaded = true;
      update();
    });
    _isMostSellingProductLoaded = true;
    update();
  }

  Future<void> refreshController() async {
    _isBannerLoaded = false;
    _isCategoriesLoaded = false;
    _isMostSellingProductLoaded = false;
    update();
    await init();
  }

  Future<void> init() async {
    if (isBannerLoaded && isCategoriesLoaded) {
      return;
    }
    await Future.wait(<Future<void>>[
      getBanners(),
      getHighlyRatedProducts(),
      getMostSellingProducts(),
      getCategories(),
    ]);
  }
}
