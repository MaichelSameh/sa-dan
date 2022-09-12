extension StringConvertor on String {
  String convertCamelCaseToUnderscore() {
    String word = "";
    for (String string in split("")) {
      if (RegExp("[A-Z]").hasMatch(string)) {
        word += "_${string.toLowerCase()}";
      } else {
        word += string;
      }
    }
    return word;
  }
}
