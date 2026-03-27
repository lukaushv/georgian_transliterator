import 'data.dart';
import 'utils.dart';

class GeorgianCore {
  static String convert(String? str, String from, String to) {
    if (str == null) return '';

    from = GeorgianUtils.normalizeAlias(from);
    to = GeorgianUtils.normalizeAlias(to);

    GeorgianUtils.checkForDirection(from, to);

    return safeConvert(str, from, to);
  }

  static String interpret(String? str, String to) {
    if (str == null) return '';

    to = GeorgianUtils.normalizeAlias(to);
    final from = GeorgianUtils.detectAlphabet(str);

    if (GeorgianUtils.isBicameral(to)) {
      return convertBicameral(str, from, to);
    } else {
      return convertUnicameral(str, from, to);
    }
  }

  static String convertUnicameral(String str, String from, String to) {
    final fromAlphabet = GeorgianData.alphabets[from];
    final toAlphabet = GeorgianData.alphabets[to];

    if (fromAlphabet == null || toAlphabet == null) {
      throw UnsupportedError("Alphabet '$from' or '$to' is not supported.");
    }

    final buffer = StringBuffer();

    for (final char in str.split('')) {
      final index = fromAlphabet.indexOf(char);
      buffer.write(index == -1 ? char : toAlphabet[index]);
    }

    return buffer.toString();
  }

  static String convertBicameral(String str, String from, String to) {
    const rules = {
      'sasataure': {
        'upper': 'asomtavruli',
        'lower': 'mtavruli',
      },
      'tfileliseuli': {
        'upper': 'mtavruli',
        'lower': 'mkhedruli',
      },
      'shanidziseuli': {
        'upper': 'asomtavruli',
        'lower': 'mkhedruli',
      },
      'khutsuri': {
        'upper': 'asomtavruli',
        'lower': 'nuskhuri',
      },
    };

    final rule = rules[to];
    if (rule == null) {
      throw UnsupportedError("Bicameral script '$to' is not supported.");
    }

    final upperScript = rule['upper']!;
    final lowerScript = rule['lower']!;

    var converted = convertUnicameral(str, from, lowerScript);

    // First letter uppercase
    converted = _capitalizeFirstConvertible(converted, lowerScript, upperScript);

    // Letters after punctuation
    converted = _capitalizeAfterSentenceEnd(converted, lowerScript, upperScript);

    // Letters before apostrophe
    converted = _capitalizeBeforeApostrophe(converted, lowerScript, upperScript);

    return converted;
  }

  static String safeConvert(String str, String from, String to) {
    if (!GeorgianUtils.isBicameral(to)) {
      return convertUnicameral(str, from, to);
    } else {
      return convertBicameral(str, from, to);
    }
  }

  static String _capitalizeFirstConvertible(String text, String from, String to) {
    final chars = text.split('');
    final fromAlphabet = GeorgianData.alphabets[from];
    final toAlphabet = GeorgianData.alphabets[to];

    if (fromAlphabet == null || toAlphabet == null) return text;

    for (int i = 0; i < chars.length; i++) {
      final idx = fromAlphabet.indexOf(chars[i]);
      if (idx != -1) {
        chars[i] = toAlphabet[idx];
        break;
      }
    }

    return chars.join();
  }

  static String _capitalizeAfterSentenceEnd(String text, String from, String to) {
    final chars = text.split('');
    final fromAlphabet = GeorgianData.alphabets[from];
    final toAlphabet = GeorgianData.alphabets[to];

    if (fromAlphabet == null || toAlphabet == null) return text;

    for (int i = 0; i < chars.length - 2; i++) {
      if ('.!?'.contains(chars[i])) {
        int j = i + 1;

        while (j < chars.length && chars[j].trim().isEmpty) {
          j++;
        }

        if (j < chars.length) {
          final idx = fromAlphabet.indexOf(chars[j]);
          if (idx != -1) {
            chars[j] = toAlphabet[idx];
          }
        }
      }
    }

    return chars.join();
  }

  static String _capitalizeBeforeApostrophe(String text, String from, String to) {
    final chars = text.split('');
    final fromAlphabet = GeorgianData.alphabets[from];
    final toAlphabet = GeorgianData.alphabets[to];

    if (fromAlphabet == null || toAlphabet == null) return text;

    for (int i = 0; i < chars.length - 1; i++) {
      if (chars[i + 1] == "'") {
        final idx = fromAlphabet.indexOf(chars[i]);
        if (idx != -1) {
          chars[i] = toAlphabet[idx];
        }
      }
    }

    return chars.join();
  }
}