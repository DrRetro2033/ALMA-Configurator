extension StringExtension on String {
  String removeQuotes() => replaceAll("\"", "");

  dynamic parse() {
    dynamic value = int.tryParse(this);
    value ??= double.tryParse(this);
    value ??= this;
    return value;
  }

  String addRequiredZerosToEnd() {
    String newStr = this;
    if (endsWith("\"")) {
      newStr.removeQuotes();
    }
    while (!newStr.endsWith("000000")) {
      newStr += "0";
    }
    return newStr;
  }
}
