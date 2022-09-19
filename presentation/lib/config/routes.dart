import 'package:flutter/material.dart';

import '../screens/screens.dart';

Map<String, Widget Function(BuildContext)> router =
    <String, Widget Function(BuildContext)>{
  AboutUsScreen.route_name: (_) =>
      const AboutUsScreen(key: Key(AboutUsScreen.route_name)),
  AddressesScreen.route_name: (_) =>
      const AddressesScreen(key: Key(AddressesScreen.route_name)),
  CategorizationDetailsScreen.route_name: (_) =>
      const CategorizationDetailsScreen(
          key: Key(CategorizationDetailsScreen.route_name)),
  ContactUsScreen.route_name: (_) =>
      const ContactUsScreen(key: Key(ContactUsScreen.route_name)),
  CreateAddressScreen.route_name: (_) =>
      const CreateAddressScreen(key: Key(CreateAddressScreen.route_name)),
  NavigationScreen.route_name: (_) =>
      const NavigationScreen(key: Key(NavigationScreen.route_name)),
  NotificationsScreen.route_name: (_) =>
      const NotificationsScreen(key: Key(NotificationsScreen.route_name)),
  LanguageScreen.route_name: (_) =>
      const LanguageScreen(key: Key(LanguageScreen.route_name)),
  OnboardingScreen.route_name: (_) =>
      const OnboardingScreen(key: Key(OnboardingScreen.route_name)),
  SplashScreen.route_name: (_) =>
      const SplashScreen(key: Key(SplashScreen.route_name)),
  StoreDetailsScreen.route_name: (_) =>
      const StoreDetailsScreen(key: Key(StoreDetailsScreen.route_name)),
  TermsConditionsScreen.route_name: (_) =>
      const TermsConditionsScreen(key: Key(TermsConditionsScreen.route_name)),

  //auth routes
  ForgotPasswordScreen.route_name: (_) =>
      const ForgotPasswordScreen(key: Key(ForgotPasswordScreen.route_name)),
  LoginScreen.route_name: (_) =>
      const LoginScreen(key: Key(LoginScreen.route_name)),
  ResetPasswordScreen.route_name: (_) =>
      const ResetPasswordScreen(key: Key(ResetPasswordScreen.route_name)),
  SignUpScreen.route_name: (_) =>
      const SignUpScreen(key: Key(SignUpScreen.route_name)),
  //end of auth routes

  //product routes
  ProductDetailsScreen.route_name: (_) =>
      const ProductDetailsScreen(key: Key(ProductDetailsScreen.route_name)),
  ProductsScreen.route_name: (_) =>
      const ProductsScreen(key: Key(ProductsScreen.route_name)),
  SearchProductsScreen.route_name: (_) =>
      const SearchProductsScreen(key: Key(SearchProductsScreen.route_name)),
  //end of product routes

  //order routes
  IncomingOrdersScreen.route_name: (_) =>
      const IncomingOrdersScreen(key: Key(IncomingOrdersScreen.route_name)),
  OrdersScreen.route_name: (_) =>
      const OrdersScreen(key: Key(OrdersScreen.route_name)),
  //end of order routes
};
