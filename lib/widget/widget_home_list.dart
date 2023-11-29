import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
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
  final ProbelmInfo prob;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SolveScreen(prob: prob)));
      },
      style: ElevatedButton.styleFrom(
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
              width: width * 0.2,
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: width * 0.2,
                    color: Colors.amber,
                  ),
                  Text(prob.uname, style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(right: width * 0.024)),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: width * 0.2,
                    child: Text(
                      prob.problem_explain[0],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 19, color: Colors.black),
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
                      FittedBox(
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
}
