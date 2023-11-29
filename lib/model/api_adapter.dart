import 'dart:convert';
import 'model_probelm.dart';

List<Problem> parseProbs(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<Problem>((json) => Problem.fromJson(json)).toList();
}
