import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../helper/api.dart';

Future<String> getChatbotResponse(String userInput) async {
  http.Response response =
      await API().get(url: 'https://flexflow-api.vercel.app/intents');
  final jsonData = json.decode(response.body);
  final intents = jsonData as List<dynamic>;

  String cleanedUserInput = normalize(userInput.toLowerCase());

  for (var intent in intents) {
    final patterns = intent['patterns'];
    final responses = List<String>.from(intent['responses']);

    for (var pattern in patterns) {
      String cleanedPattern = normalize(pattern.toLowerCase());

      if (cleanedUserInput.contains(cleanedPattern)) {
        final randomResponse = responses[Random().nextInt(responses.length)];
        return randomResponse;
      }
    }
  }

  for (var intent in intents) {
    final patterns = intent['patterns'];
    final responses = List<String>.from(intent['responses']);

    for (var pattern in patterns) {
      String cleanedPattern = normalize(pattern.toLowerCase());

      List<String> userWords = cleanedUserInput.split(" ");
      Set<String> uniqueUserWords = Set<String>.from(userWords);

      List<String> patternWords = cleanedPattern.split(" ");
      Set<String> uniquePatternWords = Set<String>.from(patternWords);

      // Count the common words between user input and pattern
      int resemblanceCount =
          uniqueUserWords.intersection(uniquePatternWords).length;

      if (resemblanceCount >= 2 && userWords.length <= 5 ||
          resemblanceCount >= 1 && userWords.length <= 3 ||
          resemblanceCount >= 4 && userWords.length <= 10 ||
          resemblanceCount >= 6 && userWords.length > 10) {
        final randomResponse = responses[Random().nextInt(responses.length)];
        return randomResponse;
      }
    }
  }
  // Fallback response when no match is found
  return "I'm sorry, I didn't understand that.\n.اسف ولكن لا اسطتيع فهم ما تقصد";
}

String normalize(String text) {
  return text
      .replaceAll('?', '')
      .replaceAll(RegExp(r'\p{P}', unicode: true), '');
}
