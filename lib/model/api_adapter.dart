import 'dart:convert';
import 'model_probelm.dart';

List<ProbelmInfo> parseProbs(String responseBody) {
  final persed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return persed.map<ProbelmInfo>((json) => ProbelmInfo.fromJson(json)).toList();
}
