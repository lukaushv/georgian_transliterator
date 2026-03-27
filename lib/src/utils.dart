import 'data.dart';

class GeorgianUtils {
  static const Map<String, String> aliases = {
    'მხედრული': 'mkhedruli',
    'ასომთავრული': 'asomtavruli',
    'ნუსხური': 'nuskhuri',
    'მთავრული': 'mtavruli',
    'ხუცური': 'khutsuri',
    'შანიძისეული': 'shanidziseuli',
    'ტფილელისეული': 'tfileliseuli',
    'სასათაურე': 'sasataure',
    'ლათინური': 'qwerty',
    'ქვერთი': 'qwerty',
  };

  static String normalizeAlias(String value) {
    return aliases[value] ?? value;
  }

  static void checkForDirection(String from, String to) {
    const permittedFrom = [
      'mkhedruli',
      'asomtavruli',
      'nuskhuri',
      'mtavruli',
      'qwerty',
    ];

    if (!permittedFrom.contains(from)) {
      throw UnsupportedError("Text conversion from '$from' is not supported.");
    }
  }

  static bool isBicameral(String to) {
    return [
      'tfileliseuli',
      'shanidziseuli',
      'khutsuri',
      'sasataure',
    ].contains(to);
  }

  static String detectAlphabet(String str) {
    for (int i = str.length - 1; i >= 0; i--) {
      final ch = str[i];
      if (GeorgianData.regex['mkhedruli']!.hasMatch(ch)) return 'mkhedruli';
      if (GeorgianData.regex['latin']!.hasMatch(ch)) return 'qwerty';
      if (GeorgianData.regex['asomtavruli']!.hasMatch(ch)) return 'asomtavruli';
      if (GeorgianData.regex['mtavruli']!.hasMatch(ch)) return 'mtavruli';
      if (GeorgianData.regex['nuskhuri']!.hasMatch(ch)) return 'nuskhuri';
    }
    return 'qwerty';
  }

  static String classifyText(String str) {
    final vector = [
      GeorgianData.regex['mkhedruli']!.hasMatch(str),
      GeorgianData.regex['mtavruli']!.hasMatch(str),
      GeorgianData.regex['asomtavruli']!.hasMatch(str),
      GeorgianData.regex['nuskhuri']!.hasMatch(str),
      GeorgianData.regex['latin']!.hasMatch(str),
    ];

    bool same(List<bool> a, List<bool> b) {
      for (int i = 0; i < a.length; i++) {
        if (a[i] != b[i]) return false;
      }
      return true;
    }

    if (same(vector, [true, false, false, false, false, false]))
      return 'mkhedruli';
    if (same(vector, [false, true, false, false, false, false]))
      return 'mtavruli';
    if (same(vector, [false, false, true, false, false, false]))
      return 'asomtavruli';
    if (same(vector, [false, false, false, true, false, false]))
      return 'nuskhuri';

    if (same(vector, [true, true, false, false, false, false]))
      return 'tfileliseuli';
    if (same(vector, [true, false, true, false, false, false]))
      return 'shanidziseuli';
    if (same(vector, [false, false, true, true, false, false]))
      return 'khutsuri';
    if (same(vector, [false, true, true, false, false, false]))
      return 'sasataure';

    if (same(vector, [false, false, false, false, true, false])) return 'latin';

    return vector.toString();
  }

  static String toUpperCaseCustom(String word, String from, String to) {
    if (word.isEmpty) return word;

    final fromAlphabet = GeorgianData.alphabets[from];
    final toAlphabet = GeorgianData.alphabets[to];

    if (fromAlphabet == null || toAlphabet == null) return word;

    final index = fromAlphabet.indexOf(word[0]);
    final converted = index == -1 ? word[0] : toAlphabet[index];

    return converted + word.substring(1);
  }
}
