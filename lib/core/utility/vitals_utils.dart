class VitalsUtils{
  static List<int> divideNumber(int number, int n) {
    List<int> parts = [];
    int increment = ((number - 1) / (n - 1)).round();
    for (int i = 0; i < n; i++) {
      int value = 1 + (increment * i);
      if (i == n - 1) {
        value = number;
      }
      parts.add(value);
    }
    return parts;
  }
}