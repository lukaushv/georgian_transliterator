import 'package:georgian_transliterator/georgian_transliterator.dart';
import 'package:test/test.dart';

void main() {
  group('Georgian transliterator tests', () {
    test('Mkhedruli to Asomtavruli', () {
      expect(
        GeorgianTransliterator.convert('აბგ', 'mkhedruli', 'asomtavruli'),
        'ႠႡႢ',
      );
    });

    test('Mkhedruli to Nuskhuri', () {
      expect(
        GeorgianTransliterator.convert('აბგ', 'mkhedruli', 'nuskhuri'),
        'ⴀⴁⴂ',
      );
    });

    test('Asomtavruli to Mkhedruli', () {
      expect(
        GeorgianTransliterator.convert('ႠႡႢ', 'asomtavruli', 'mkhedruli'),
        'აბგ',
      );
    });

    test('Nuskhuri to Mkhedruli', () {
      expect(
        GeorgianTransliterator.convert('ⴀⴁⴂ', 'nuskhuri', 'mkhedruli'),
        'აბგ',
      );
    });

    test('Khutsuri conversion capitalizes first letter', () {
      expect(
        GeorgianTransliterator.convert('აბგ', 'mkhedruli', 'khutsuri'),
        'Ⴀⴁⴂ',
      );
    });

    test('Interpret detects source alphabet automatically', () {
      expect(GeorgianTransliterator.interpret('ႠႡႢ', 'mkhedruli'), 'აბგ');
    });

    test('Classify Mkhedruli text', () {
      expect(GeorgianTransliterator.classify('ქართული'), 'mkhedruli');
    });

    test('Classify Asomtavruli text', () {
      expect(GeorgianTransliterator.classify('ႵႠႰႧႳႪႨ'), 'asomtavruli');
    });

    test('Preserves punctuation', () {
      expect(
        GeorgianTransliterator.convert('აბგ, დე!', 'mkhedruli', 'asomtavruli'),
        'ႠႡႢ, ႣႤ!',
      );
    });

    test('Preserves Latin and unknown chars', () {
      expect(
        GeorgianTransliterator.convert(
          'abc აბგ 123',
          'mkhedruli',
          'asomtavruli',
        ),
        'abc ႠႡႢ 123',
      );
    });
  });
}
