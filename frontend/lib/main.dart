import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'package:quiz_app_test/screen/screen_home.dart';
import 'package:quiz_app_test/screen/screen_signin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => loginUser()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'DB Quiz App',
      home: SigninForm(),
    );
  }
}
