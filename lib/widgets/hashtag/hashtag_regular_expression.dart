import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/widgets/hashtag/detector.dart';

const _symbols = '·・ー_';

const _numbers = '0-9０-９';

const _englishLetters = 'a-zA-Zａ-ｚＡ-Ｚ';

const _japaneseLetters = 'ぁ-んァ-ン一-龠';

const _koreanLetters = '\u1100-\u11FF\uAC00-\uD7A3';

const _spanishLetters = 'áàãâéêíóôõúüçÁÀÃÂÉÊÍÓÔÕÚÜÇ';

const _arabicLetters = '\u0621-\u064A';

const _thaiLetters = '\u0E00-\u0E7F';

const _norwegianLetters = 'åøæ';

const _germanLetters = 'ÄäÖöÜüẞß';

const _turkishLetters = 'IıÖöŞşÇçÜüĞğ';

const hashTagContentLetters = _symbols +
    _numbers +
    _englishLetters +
    _japaneseLetters +
    _koreanLetters +
    _spanishLetters +
    _arabicLetters +
    _thaiLetters +
    _norwegianLetters +
    _turkishLetters +
    _germanLetters;

/// Regular expression to extract hashtag from text
///
/// Supports English, Japanese, Korean, Spanish, Arabic, and Thai
final hashTagRegExp = RegExp(
  '(?!\\n)(?:^|\\s)(#([$hashTagContentLetters]+))',
  multiLine: true,
);

/// Regular expression when you select decorateAtSign
final hashTagAtSignRegExp = RegExp(
  '(?!\\n)(?:^|\\s)([#@]([$hashTagContentLetters]+))',
  multiLine: true,
);

/// Extract hashTags from the text
List<String> extractHashTags(String value) {
  final decoratedTextColor = Colors.blue;
  final detector = Detector(
      textStyle: TextStyle(),
      decoratedStyle: TextStyle(color: decoratedTextColor));
  final detections = detector.getDetections(value);
  final taggedDetections = detections
      .where((detection) => detection.style!.color == decoratedTextColor)
      .toList();
  final result = taggedDetections.map((decoration) {
    final text = decoration.range.textInside(value);
    return text.trim();
  }).toList();
  return result;
}
