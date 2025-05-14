import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_problem_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';
import 'package:intl/intl.dart';

class SolveScreen extends StatefulWidget {
  Problem prob;
  SolveScreen({required this.prob});

  @override
  State<SolveScreen> createState() => _SolveScreenState();
}

class _SolveScreenState extends State<SolveScreen> {
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: height * 0.4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(width * 0.06),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.024, width * 0.024, width * 0.024, 0),
                    child: Text(
                      widget.prob.sname,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.024, width * 0.024, width * 0.024, 0),
                    child: Text(
                      '정답률 : ' +
                          ((widget.prob.accnt / widget.prob.trycnt) * 100)
                              .toStringAsFixed(2) +
                          '%',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.024, width * 0.024, width * 0.024, 0),
                    child: Text(
                      'made by [ ' +
                          widget.prob.uname +
                          ' ]\non ' +
                          DateFormat('yyyy/MM/dd HH:mm:ss')
                              .format(DateTime.parse(widget.prob.ptime)),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.024, width * 0.024, width * 0.024, 0),
                    child: Text(
                      'Q. ' + widget.prob.problem_explain[0],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: height * 0.4),
              margin: EdgeInsets.fromLTRB(width * 0.06, 0, width * 0.06, 0),
              child: ListView(
                children: [
                  for (int i = 1; i < widget.prob.problem_explain.length; i++)
                    CandWidget(
                      index: i,
                      text: widget.prob.problem_explain[i],
                      width: width,
                      selected_state: _answerState[i - 1],
                      tap: () {
                        setState(() {
                          for (int j = 0; j < 4; j++) {
                            if (j == i - 1) {
                              _answerState[j] = true;
                              _currentIndex = i;
                            } else {
                              _answerState[j] = false;
                            }
                          }
                        });
                      },
                    ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                "정답 제출",
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (_currentIndex != 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultProblemPage(
                              prob: widget.prob, selected_ans: _currentIndex)));
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: BorderSide(color: Colors.black, width: 2),
                backgroundColor:
                    _currentIndex == 0 ? Colors.grey : Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                fixedSize: Size(width * 0.4, height * 0.05),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
