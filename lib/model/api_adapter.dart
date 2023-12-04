import 'dart:convert';
import 'package:quiz_app_test/model/model_comment.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'model_probelm.dart';
import 'package:quiz_app_test/model/model_answer.dart';

List<Problem> parseProbs(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<Problem>((json) => Problem.fromJson(json)).toList();
}

List<Comment> parseComm(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<Comment>((json) => Comment.fromJson(json)).toList();
}

loginUser parseLogin(String responseBody) {
  return loginUser.fromJson(json.decode(responseBody));
}

List<Answer> parseAns(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<Answer>((json) => Answer.fromJson(json)).toList();
}
