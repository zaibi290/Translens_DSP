
import 'dart:convert';


class FavoriteListModel{
  String translatedText;
  String enteredText;
  String fromLanguage;
  String toLanguage;

  FavoriteListModel ({
    required this.translatedText,
    required this.fromLanguage,
    required this.enteredText,
    required this.toLanguage,
});

  String toJson() => jsonEncode({
    'translatedText': translatedText,
    'enteredText': enteredText,
    'fromLanguage': fromLanguage,
    'toLanguage': toLanguage,
  });

  factory FavoriteListModel.fromJson(String jsonStr) {
    final Map<String, dynamic> jsonData = jsonDecode(jsonStr);
    return FavoriteListModel(
      translatedText: jsonData['translatedText'],
      enteredText: jsonData['enteredText'],
      fromLanguage: jsonData['fromLanguage'],
      toLanguage: jsonData['toLanguage'],
    );
  }
}


class FAQ{
  late String questions;
  late String answers;

  FAQ({required this.questions, required this.answers});
}

class LanguageModel{
  late String language;
  late String code;
  late String codeForVoice;


  LanguageModel({required this.language, required this.code, required this.codeForVoice});
}


