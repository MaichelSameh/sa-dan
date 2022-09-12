import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlServices {
  Future<void> launchUrl(String url, {bool inApp = true}) async {
    await url_launcher.launchUrl(
      Uri.parse(url),
      mode: inApp
          ? url_launcher.LaunchMode.inAppWebView
          : url_launcher.LaunchMode.externalApplication,
      webViewConfiguration:
          const url_launcher.WebViewConfiguration(enableJavaScript: true),
    );
  }

  Future<void> contactViaWhatsApp({required String phoneNumber}) async {
    await url_launcher
        .launchUrl(Uri.parse("whatsapp://send?phone=$phoneNumber"));
  }

  Future<void> contactViaMail({required String receiver}) async {
    await url_launcher.launchUrl(Uri.parse("mailto:$receiver"));
  }
}
