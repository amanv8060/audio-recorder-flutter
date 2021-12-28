String formatNumber(int number) {
  String numberStr = number.toString();
  if (number < 10) {
    numberStr = '0' + numberStr;
  }
  return numberStr;
}
