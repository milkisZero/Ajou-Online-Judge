import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_debate.dart';
import 'package:quiz_app_test/screen/screen_solve.dart';
import 'dart:convert';

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SolveScreen(prob: prob)));
      },
      style: ElevatedButton.styleFrom(
        shape: BeveledRectangleBorder(),
        side: BorderSide(color: Colors.black, width: 0.5),
        backgroundColor: Colors.transparent,
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
                      child: userIcon(prob.upoint)),
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
                      if (prob.pstate == 1)
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: width * 0.2,
                              child: Text(
                                "토론 중",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: width * 0.012)),
                          ],
                        ),
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

  Image userIcon(int upoint) {
    if (prob.upoint < 100) {
      return Image.asset(
        'assets/images/start.png',
        scale: 4,
      );
    } else if (prob.upoint < 200) {
      return Image.asset(
        'assets/images/cat.png',
        scale: 4,
      );
    } else if (prob.upoint < 300) {
      return Image.asset(
        'assets/images/cat3.png',
        scale: 4,
      );
    } else {
      return Image.asset(
        'assets/images/cat2.png',
        scale: 4,
      );
    }
  }
}
