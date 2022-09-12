// import 'package:data/enums.dart';
// import 'package:data/models/models.dart';
// import 'package:domain/services/services.dart';
// import 'package:get/get.dart';

// import '../widgets/error_handler.dart';
// import 'controllers.dart';

// class HomeController extends GetxController {
//   List<BannerInfo> _banners = <BannerInfo>[];
//   List<CategoryInfo> _categories = <CategoryInfo>[];
//   List<ProductInfo> _products = <ProductInfo>[];

//   bool _isBannerLoaded = false;
//   bool _isCategoriesLoaded = false;
//   bool _isProductsLoaded = false;

//   String? _selectedTab;

//   SocialInfo? _socialInfo;

//   List<String> _currencies = <String>[];

//   List<BannerInfo> get banners => _banners;
//   List<BannerInfo> get mainHomeSlider => banners
//       .where((BannerInfo element) =>
//           element.bannerPosition == BannerPosition.homeMainSlider)
//       .toList();
//   List<BannerInfo> get secondaryHomeSlider => banners
//       .where((BannerInfo element) =>
//           element.bannerPosition == BannerPosition.homeSecondSlider)
//       .toList();
//   List<BannerInfo> get thirdHomeSlider => banners
//       .where((BannerInfo element) =>
//           element.bannerPosition == BannerPosition.homeThirdSlider)
//       .toList();
//   List<BannerInfo> get categorySlider => banners
//       .where((BannerInfo element) =>
//           element.bannerPosition == BannerPosition.categoryPageBanner)
//       .toList();
//   List<CategoryInfo> get categories => _categories;
//   List<ProductInfo> get products => _products;

//   SocialInfo? get socialInfo => _socialInfo;

//   List<String> get currencies => _currencies;

//   bool get isBannerLoaded => _isBannerLoaded;
//   bool get isCategoriesLoaded => _isCategoriesLoaded;
//   bool get isProductsLoaded => _isProductsLoaded;

//   CategoryInfo? get selectedTab =>
//       categories.firstWhereOrNull(
//           (CategoryInfo element) => element.id == _selectedTab) ??
//       (categories.isEmpty ? null : categories.first);

//   void onSelectedTapChange(String tab) {
//     _selectedTab = tab;
//     _isProductsLoaded = false;
//     getProducts();
//     update();
//   }

//   Future<void> getBanners() async {
//     _banners = await BannerServices()
//         .getAll(
//       lang: Get.locale?.languageCode,
//       currency: Get.find<UserController>().currency,
//       token: Get.find<UserController>().token?.token.combinedToken,
//     )
//         .catchError((dynamic error) {
//       errorHandler(error);
//       _isBannerLoaded = true;
//       update();
//     });
//     _isBannerLoaded = true;
//     update();
//   }

//   Future<void> getCategories() async {
//     _categories = await CategoryServices()
//         .getAll(
//       lang: Get.locale?.languageCode,
//       currency: Get.find<UserController>().currency,
//       token: Get.find<UserController>().token?.token.combinedToken,
//     )
//         .catchError((dynamic error) {
//       errorHandler(error);
//       _isCategoriesLoaded = true;
//       update();
//     });
//     _isCategoriesLoaded = true;
//     getProducts();
//     update();
//   }

//   Future<void> getProducts() async {
//     if (isProductsLoaded) {
//       return;
//     }
//     _products = await CategoryServices()
//         .getProducts(
//       lang: Get.locale?.languageCode,
//       currency: Get.find<UserController>().currency,
//       categoryId: selectedTab?.id ?? categories.first.id,
//       token: Get.find<UserController>().token?.token.combinedToken,
//     )
//         .catchError((dynamic error) {
//       errorHandler(error);
//       _isProductsLoaded = true;
//       update();
//     });
//     _isProductsLoaded = true;
//     update();
//   }

//   Future<void> refreshController() async {
//     _isBannerLoaded = false;
//     _isCategoriesLoaded = false;
//     _isProductsLoaded = false;
//     update();
//     await init();
//     await getProducts();
//   }

//   Future<void> init() async {
//     if (isBannerLoaded && isCategoriesLoaded) {
//       return;
//     }
//     await Future.wait(<Future<void>>[
//       getBanners(),
//       getCategories(),
//     ]);
//   }

//   Future<void> initSocial() async {
//     GeneralInfo temp = await GeneralServices()
//         .getGeneralData(lang: Get.locale?.languageCode)
//         .catchError((dynamic error) {
//       errorHandler(error);
//     });
//     _socialInfo = temp.social;
//     _currencies = temp.currencies;
//   }

//   @override
//   void onInit() {
//     initSocial();
//     super.onInit();
//   }
// }
