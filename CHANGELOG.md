# georgian_transliterator

A Dart package for converting and transliterating Georgian scripts such as:

- **Mkhedruli** (მხედრული)
- **Mtavruli** (მთავრული)
- **Asomtavruli** (ასომთავრული)
- **Nuskhuri** (ნუსხური)

It also supports Georgian bicameral writing styles such as:

- **Khutsuri** (ხუცური)
- **Shanidziseuli** (შანიძისეული)
- **Tfileliseuli** (ტფილელისეული)
- **Sasataure** (სასათაურე)

---

## Features

- Convert between Georgian scripts
- Auto-detect input script with `interpret()`
- Detect/classify script type
- Preserve punctuation, spaces, and unknown characters
- Includes optional text analysis helpers (`frequency`, `count`, `friedman`)

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  georgian_transliterator: ^0.1.1
```

Then run:

```bash
dart pub get
```

or in Flutter:

```bash
flutter pub get
```

---

## Usage

### Import

```dart
import 'package:georgian_transliterator/georgian_transliterator.dart';
```

---

## Basic conversion

### Mkhedruli → Asomtavruli

```dart
final result = GeorgianTransliterator.convert(
  'ქართული',
  'mkhedruli',
  'asomtavruli',
);

print(result); // ႵႠႰႧႳႪႨ
```

---

### Mkhedruli → Nuskhuri

```dart
final result = GeorgianTransliterator.convert(
  'ქართული',
  'mkhedruli',
  'nuskhuri',
);

print(result); // ⴕⴐⴇⴓⴊⴈ
```

---

### Mkhedruli → Khutsuri

```dart
final result = GeorgianTransliterator.convert(
  'ქართული',
  'mkhedruli',
  'khutsuri',
);

print(result); // Ⴕⴐⴇⴓⴊⴈ
```

---

## Auto-detect source script

Use `interpret()` if you don't want to specify the source alphabet manually.

```dart
final result = GeorgianTransliterator.interpret(
  'ႵႠႰႧႳႪႨ',
  'mkhedruli',
);

print(result); // ქართული
```

---

## Classify script

```dart
final kind = GeorgianTransliterator.classify('ⴀⴁⴂ');
print(kind); // nuskhuri
```

---

## Toolkit helpers

### Character frequency

```dart
final freq = GeorgianToolkit.frequency('ქართული ტექსტი');
print(freq);
```

### Character count

```dart
final counts = GeorgianToolkit.count('ქართული ტექსტი');
print(counts);
```

### Friedman index

```dart
final index = GeorgianToolkit.friedman('ქართული ტექსტი');
print(index);
```

---

## Supported scripts (currently)

### Core scripts
- `mkhedruli`
- `mtavruli`
- `asomtavruli`
- `nuskhuri`
- `qwerty`

### Bicameral styles
- `khutsuri`
- `shanidziseuli`
- `tfileliseuli`
- `sasataure`

---

## Aliases

Some Georgian aliases are supported, for example:

- `მხედრული` → `mkhedruli`
- `ასომთავრული` → `asomtavruli`
- `ნუსხური` → `nuskhuri`
- `მთავრული` → `mtavruli`
- `ხუცური` → `khutsuri`

Example:

```dart
final result = GeorgianTransliterator.convert(
  'ქართული',
  'მხედრული',
  'ასომთავრული',
);
```

---

## Notes

This is currently **v0.1.1** and focuses on the main Georgian writing systems.

Future versions may include:

- Braille support
- IPA / phonetic mappings
- Romanization systems
- More advanced transliteration parsing for multi-character alphabets

---

## License

MIT