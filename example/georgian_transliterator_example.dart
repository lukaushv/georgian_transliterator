import 'package:georgian_transliterator/georgian_transliterator.dart';

void main() {
  const text = 'ქართული ენა მშვენიერია. საქართველო!';

  print('Original: $text');
  print('');

  print('Mkhedruli → Asomtavruli:');
  print(GeorgianTransliterator.convert(text, 'mkhedruli', 'asomtavruli'));
  print('');

  print('Mkhedruli → Nuskhuri:');
  print(GeorgianTransliterator.convert(text, 'mkhedruli', 'nuskhuri'));
  print('');

  print('Mkhedruli → Khutsuri:');
  print(GeorgianTransliterator.convert(text, 'mkhedruli', 'khutsuri'));
  print('');

  print('Interpret Asomtavruli → Mkhedruli:');
  print(GeorgianTransliterator.interpret('ႵႠႰႧႳႪႨ', 'mkhedruli'));
  print('');

  print('Classify text:');
  print(GeorgianTransliterator.classify('ⴀⴁⴂ'));
  print('');

  print('Toolkit frequency:');
  print(GeorgianToolkit.frequency('ქართული ტექსტი'));
}