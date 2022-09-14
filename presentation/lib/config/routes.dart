import 'package:flutter/material.dart';

import '../screens/screens.dart';

Map<String, Widget Function(BuildContext)> router =
    <String, Widget Function(BuildContext)>{
  NavigationScreen.route_name: (_) =>
      const NavigationScreen(key: Key(NavigationScreen.route_name)),
  LanguageScreen.route_name: (_) =>
      const LanguageScreen(key: Key(LanguageScreen.route_name)),
  OnboardingScreen.route_name: (_) =>
      const OnboardingScreen(key: Key(OnboardingScreen.route_name)),
  SplashScreen.route_name: (_) =>
      const SplashScreen(key: Key(SplashScreen.route_name)),

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
};
