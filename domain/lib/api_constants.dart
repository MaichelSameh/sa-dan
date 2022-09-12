// ignore_for_file: constant_identifier_names

class ApiConstants {
  static const String server_protocol = "https://";

  //banner paths
  static const String banner_path = "banners";
  //end of banner paths

  //general info paths
  static const String general_path = "general";
  //end of general info paths

  //notifications paths
  static const String notification_path = "orders/notifications";
  //end of notifications paths

  //notification channels paths
  static const String email_notification_channel =
      "notifications/send-via/email";
  //end of notification channels paths

  //contact paths
  static const String contact_path = "contacts";
  //end of contact paths

  //auth paths
  static const String login_path = "login";
  static const String logout_path = "logout";
  static const String register_path = "register";
  static const String social_login_path = "social/process";
  //end of auth paths

  //availability paths
  static const String check_email_availability = "check-email-availability";
  static const String check_phone_availability = "check-phone-availability";
  //end availability paths

  //profile paths
  static const String update_password_path = "profile/update/password";
  static const String profile_fcm_path =
      "profile/update/firebase-cloud-messaging-token";
  static const String profile_logo_path = "profile/update/logo";
  static const String profile_path = "profile";
  static const String profile_update_path = "profile/update";
  static const String delete_account_path = "profile/delete-account";
  static const String reset_password_path = "password/reset-by-email";
  //end of profile paths

  //faqs paths
  static const String faq_path = "faqs";
  //end of faqs paths

}
