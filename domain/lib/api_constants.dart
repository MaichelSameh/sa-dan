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

  //address path
  static const String address_path = "user/addresses";
  //end of address path

  //customer order paths
  static const String customer_delivered_orders_path =
      "customer/profile/orders/delivered";
  static const String customer_active_orders_path =
      "customer/profile/orders/active";
  static const String customer_make_order_path = "products/order";
  static const String order_path = "orders";
  static const String customer_cancel_order_path = "orders/cancel";
  //end of customer order paths

  //driver order paths
  static const String driver_running_orders = "driver/profile/orders/running";
  //end of driver order paths

  //store path
  static const String store_path = "stores";
  //end of store path

  //category path
  static const String category_path = "categorizations";
  //end of category path

  //category path
  static const String product_path = "products";
  static const String top_rated_product_path = "products/top-rated";
  static const String top_selling_product_path = "products/top-selling";
  static const String favorites_path = "products/favorites";
  static const String search_products_path = "search";
  //end of category path
}
