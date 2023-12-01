import 'package:flutter/material.dart';

class SigninFormData {
  String? uid;
  String? upwd;

  SigninFormData({this.uid, this.upwd});

  Map<String, dynamic> toJson() => {
        "id": uid,
        "pwd": upwd,
      };
}

class loginUser with ChangeNotifier {
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

  loginUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pwd = json['pwd'],
        upoint = json['upoint'],
        uname = json['uname'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {"id": id, "pwd": pwd, "upoint": upoint, "uname": uname, "email": email};
}
