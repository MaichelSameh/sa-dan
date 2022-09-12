class AboutInfo {
  late String? _aboutUs;
  late String? _termsAndConditions;
  late String? _privacyPolicy;

  AboutInfo({
    String? aboutUs,
    String? termsAndConditions,
    String? privacyPolicy,
  }) {
    _aboutUs = aboutUs;
    _termsAndConditions = termsAndConditions;
    _privacyPolicy = privacyPolicy;
  }
  AboutInfo.fromJson(Map<String, dynamic> data) {
    _aboutUs = data["about_us"];
    _termsAndConditions = data["terms_and_conditions"];
    _privacyPolicy = data["privacy_policy"];
  }

  ///this parameter contains the about page content in html format
  String? get aboutUs => _aboutUs;

  ///this parameter contains the terms and conditions content in html format
  String? get termsAndConditions => _termsAndConditions;

  ///this parameter contains the privacy policy content in html format
  String? get privacyPolicy => _privacyPolicy;

  @override
  String toString() =>
      'AboutInfo(_aboutUs: $_aboutUs, _termsAndConditions: $_termsAndConditions, _privacyPolicy: $_privacyPolicy)';
}
