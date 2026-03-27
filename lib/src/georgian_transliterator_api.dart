import 'core.dart';
import 'utils.dart';

/// A utility class for converting and classifying Georgian scripts.
///
/// Supports Georgian writing systems such as:
/// - Mkhedruli
/// - Mtavruli
/// - Asomtavruli
/// - Nuskhuri
///
/// Also supports bicameral styles such as:
/// - Khutsuri
/// - Shanidziseuli
/// - Tfileliseuli
/// - Sasataure
class GeorgianTransliterator {
  /// Converts [text] from one script to another.
  ///
  /// Example:
  /// ```dart
  /// GeorgianTransliterator.convert('ქართული', 'mkhedruli', 'asomtavruli');
  /// ```
  static String convert(String text, String from, String to) {
    return GeorgianCore.convert(text, from, to);
  }

  /// Automatically detects the source script and converts it to [to].
  ///
  /// Useful when the input text script is unknown.
  static String interpret(String text, String to) {
    return GeorgianCore.interpret(text, to);
  }

  /// Detects the likely script or writing style used in [text].
  ///
  /// Example return values:
  /// - `mkhedruli`
  /// - `asomtavruli`
  /// - `nuskhuri`
  /// - `khutsuri`
  static String classify(String text) {
    return GeorgianUtils.classifyText(text);
  }
}