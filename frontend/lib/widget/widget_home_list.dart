import 'package:flutter/material.dart';
import 'package:quiz_app_test/api_adapter.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_debate.dart';
import 'package:quiz_app_test/screen/screen_solve.dart';
import 'package:quiz_app_test/widget/widget_usericon.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'package:provider/provider.dart';

class build_home_list extends StatelessWidget {
  const build_home_list({
    super.key,
    required this.context,
    required this.width,
    required this.prob,
  });

  final BuildContext context;
  final double width;
  final Problem prob;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (prob.plike > 80) {
          askPayPoint("해당 문제는 50포인트가 차감됩니다.");
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SolveScreen(prob: prob)));
        }
      },
      style: ElevatedButton.styleFrom(
        shape: BeveledRectangleBorder(),
        side: BorderSide(color: Colors.black, width: 0.5),
        backgroundColor:
            prob.plike >= 80 ? Colors.grey.shade300 : Colors.transparent,
        elevation: 0,
      ),
      child: Container(
        padding:
            EdgeInsets.fromLTRB(0, width * 0.024, width * 0.024, width * 0.024),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: width * 0.15,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(width * 0.012),
                      child: widget_usericon(upoint: prob.upoint)),
                  Container(
                    padding: EdgeInsets.all(width * 0.012),
                    child: Text(
                      prob.uname,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(right: width * 0.024)),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (prob.pstate == 1)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: width * 0.2,
                          child: Text(
                            "DEBATING",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (prob.pstate == 1)
                        Padding(padding: EdgeInsets.only(right: width * 0.024)),
                      if (prob.plike >= 80)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: width * 0.2,
                          child: Text(
                            "PREMIUN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (prob.plike >= 80)
                        Padding(padding: EdgeInsets.only(right: width * 0.024)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: width * 0.2,
                        child: Text(
                          ((prob.accnt / prob.trycnt) * 100)
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: width * 0.2,
                    child: Text(
                      prob.problem_explain[0],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: width * 0.024)),
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up_alt,
                        size: width * 0.05,
                        color: Colors.red,
                      ),
                      Padding(padding: EdgeInsets.only(right: width * 0.012)),
                      Text(prob.plike.toString(),
                          style: TextStyle(color: Colors.red)),
                      Padding(padding: EdgeInsets.only(right: width * 0.024)),
                      Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.lightBlue.shade50,
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: Text(
                          prob.sname,
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void payPoint() async {
    final result = await http.get(Uri.http('13.209.70.215:8000',
        'quiz/pay/point/${Provider.of<loginUser>(context, listen: false).id}/'));

    if (result.statusCode == 201) {
      _showDialog('차감되었습니다');
      Navigator.of(context).pop();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SolveScreen(prob: prob)));
    } else {
      _showDialog('포인트가 부족합니다');
    }
  }

  void askPayPoint(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop();
                  payPoint();
                },
              ),
              TextButton(
                child: const Text('NO'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
