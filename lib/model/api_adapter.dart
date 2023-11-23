import 'dart:convert';
import 'model_quiz.dart';

List<Quiz> parseQuizes(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}

List<ProbelmInfo> parseProbs(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<ProbelmInfo>((json) => ProbelmInfo.fromJson(json)).toList();
}
