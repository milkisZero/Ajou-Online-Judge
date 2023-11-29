import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';

class DebateScreen extends StatefulWidget {
  DebateScreen({required this.prob});

  final Problem prob;

  @override
  State<DebateScreen> createState() => _DebateScreenState();
}

class _DebateScreenState extends State<DebateScreen> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.lightBlue.shade50,
          ),
        ),
      ),
    );
  }

  Widget _buildComments(Quiz quiz, double width, double height) {
    return Container();
  }
}
