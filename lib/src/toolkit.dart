class GeorgianToolkit {
  static Map<String, double> frequency(
    String text, {
    String missPattern = r"[ა-ჰᲐ-ᲰႠ-Ⴠⴀ-ⴠa-zA-ZА]",
  }) {
    final chars = text.toUpperCase().split('');
    final table = <String, double>{};
    final regex = RegExp(missPattern);

    for (final ch in chars) {
      if (!regex.hasMatch(ch)) continue;
      table[ch] = (table[ch] ?? 0) + 1;
    }

    final length = chars.length;
    if (length == 0) return table;

    table.updateAll((key, value) => value / length);
    return table;
  }

  static Map<String, int> count(
    String text, {
    String missPattern = r"[ა-ჰᲐ-ᲰႠ-Ⴠⴀ-ⴠa-zA-ZА]",
  }) {
    final chars = text.toUpperCase().split('');
    final table = <String, int>{};
    final regex = RegExp(missPattern);

    for (final ch in chars) {
      if (!regex.hasMatch(ch)) continue;
      table[ch] = (table[ch] ?? 0) + 1;
    }

    return table;
  }

  static double friedman(
    String text, {
    String missPattern = r"[ა-ჰᲐ-ᲰႠ-Ⴠⴀ-ⴠa-zA-ZА]",
  }) {
    final table = count(text, missPattern: missPattern);
    int sum = 0;
    int total = 0;

    for (final value in table.values) {
      sum += value * (value - 1);
      total += value;
    }

    return total > 1 ? sum / (total * (total - 1)) : 0;
  }
}
