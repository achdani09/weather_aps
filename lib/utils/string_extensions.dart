extension StringExtension on String {
  String get capitalizeFirstofEach {
    if (isEmpty) return this;
    return split(" ").map((str) => str.isNotEmpty ? str[0].toUpperCase() + str.substring(1).toLowerCase() : "").join(" ");
  }
}