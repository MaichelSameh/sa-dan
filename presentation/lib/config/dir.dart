// ignore_for_file: constant_identifier_names

class Dir {
  static const String emoji_path = "assets/emojis/";
  static const String emoji_suffix = "-emoji.svg";
  static const String icon_path = "assets/icons/";
  static const String icon_suffix = "-icon.svg";
  static const String illustration_path = "assets/illustrations/";
  static const String illustration_suffix = "-illustration.svg";
  static const String image_path = "assets/images/";
  static const String image_suffix = ".png";
  static const String logo_path = "assets/logos/";
  static const String logo_suffix = ".png";

  static String getEmojiPath(String emojiName, [String? iconExtension]) {
    return emoji_path + emojiName + (iconExtension ?? emoji_suffix);
  }

  static String getIconPath(String iconName, [String? iconExtension]) {
    return icon_path + iconName + (iconExtension ?? icon_suffix);
  }

  static String getIllustrationPath(String illustrationName,
      [String? illustrationExtension]) {
    return illustration_path +
        illustrationName +
        (illustrationExtension ?? illustration_suffix);
  }

  static String getImagePath(String imageName, [String? imageExtension]) {
    return image_path + imageName + (imageExtension ?? image_suffix);
  }

  static String getLogoPath(String logoName, [String? logoExtension]) {
    return logo_path + logoName + (logoExtension ?? logo_suffix);
  }
}
