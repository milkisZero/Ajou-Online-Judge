import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:quiz_app_test/screen/screen_signup.dart';
import 'package:flutter/material.dart';
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

class SigninForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SigninForm();
}

class _SigninForm extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();
  SigninFormData formData = SigninFormData();

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(10),
          child: Form(
            key: this.formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: ValueKey(1),
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      labelText: 'id'),
                  onChanged: (value) {
                    formData.uid = value;
                  },
                ),
                TextFormField(
                  key: ValueKey(2),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_open_outlined),
                      labelText: 'password'),
                  onChanged: (value) {
                    formData.upwd = value;
                  },
                ),
                SizedBox(
                    height:
                        20), // Add some vertical spacing between text fields and buttons
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Adjust as needed
                  children: [
                    ElevatedButton(
                      child: const Text('Signin'),
                      onPressed: () {
                        addTaskToServer();
                        setState(() {});
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Signup'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupForm()));
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  child: const Text('바로가기'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void addTaskToServer() async {
    String jsonResult = jsonEncode(formData.toJson());
    print(jsonResult);
    final result = await http.post(
      Uri.http('13.209.70.215:8000', 'quiz/check/user/'),
      headers: {'content-type': 'application/json'},
      body: jsonResult,
    );
    if (result.statusCode == 200) {
      _showDialog('Successfully signed in');
      isLogin = true;
    } else {
      _showDialog('Failed to sign in');
    }
    if (isLogin) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
