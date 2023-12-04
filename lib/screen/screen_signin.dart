import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:quiz_app_test/screen/screen_signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    loginUser login_user = Provider.of<loginUser>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/book.png',
                scale: 4,
                color: Colors.amber,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                ),
                Text(
                  "jou ",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "O",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                ),
                Text(
                  "nline ",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "J",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent),
                ),
                Text(
                  "udge",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Center(
              child: Text(
                "아오지",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
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
                    Padding(padding: EdgeInsets.all(width * 0.048)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: BorderSide(color: Colors.black, width: 2),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(width * 0.2, width * 0.1),
                          ),
                          child: const Text(
                            'SignIn',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            addTaskToServer(login_user);
                            setState(() {});
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: BorderSide(color: Colors.black, width: 2),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(width * 0.2, width * 0.1),
                          ),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupForm()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  void addTaskToServer(loginUser login_user) async {
    String jsonResult = jsonEncode(formData.toJson());
    final result = await http.post(
      Uri.http('13.209.70.215:8000', 'quiz/check/user/'),
      headers: {'content-type': 'application/json'},
      body: jsonResult,
    );
    if (result.statusCode == 200) {
      _showDialog('Successfully signed in');

      loginUser tmp = parseLogin(utf8.decode(result.bodyBytes));
      login_user.loginApp(tmp);

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
