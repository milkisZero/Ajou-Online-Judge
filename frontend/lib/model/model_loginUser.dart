import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SigninFormData {
  String? uid;
  String? upwd;

  SigninFormData({this.uid, this.upwd});

  Map<String, dynamic> toJson() => {
        "id": uid,
        "pwd": upwd,
      };
}

class loginUser extends ChangeNotifier {
  String? id;
  String? pwd;
  int? upoint;
  String? uname;
  String? email;

  loginUser({this.id, this.pwd, this.upoint, this.uname, this.email});

  void loginApp(loginUser tmp) {
    id = tmp.id;
    pwd = tmp.pwd;
    upoint = tmp.upoint;
    uname = tmp.uname;
    email = tmp.email;
    notifyListeners();
  }

  Future<void> fetchPoint() async {
    final response =
        await http.get(Uri.http('13.209.70.215:8000', 'quiz/get/point/${id}/'));

    if (response.statusCode == 200) {
      upoint = int.parse(utf8.decode(response.bodyBytes));
      // notifyListeners();
    } else {
      throw Exception('faild to load data');
    }
  }

  loginUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pwd = json['pwd'],
        upoint = json['upoint'],
        uname = json['uname'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {"id": id, "pwd": pwd, "upoint": upoint, "uname": uname, "email": email};
}
