// import 'package:translator/translator.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_langdetect/language.dart';
// import 'package:flutter_langdetect/flutter_langdetect.dart';

// void textToSpeech(String text) async {
//   final flutterTts = FlutterTts();

//   // Detect the language of the input text
//   String detectedLanguage = await detectLanguage(text);

//   // Set the language and translation based on the detected language
//   if (detectedLanguage == 'ar') {
//     // Translate Arabic text to English
//     String translatedText = await translateText(text, 'ar', 'en');
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(translatedText);
//   } else {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(text);
//   }
// }

// Future<String> detectLanguage(String text) async {
//   // Detect the language of the input text
//   LanguageDetector detector = LanguageDetector();
//   Language detectedLanguage = await detector.detect(text);
//   return detectedLanguage.languageCode;
// }

// Future<String> translateText(
//     String text, String sourceLang, String targetLang) async {
//   // Translate the text using Googletrans
//   final translator = GoogleTranslator();
//   Translation translation =
//       await translator.translate(text, from: sourceLang, to: targetLang);
//   return translation.text;
// }
