import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_comment.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_debate.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class buildComments extends StatelessWidget {
  const buildComments({
    super.key,
    required this.widget,
    required this.comm,
    required this.width,
    required this.height,
  });

  final DebateScreen widget;
  final Comment comm;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(right: width * 0.024)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              padding: EdgeInsets.all(width * 0.012),
              child: Text(
                comm.uname,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              decoration: BoxDecoration(
                border: Border.all(
                    color: widget.prob.uname == comm.makerID
                        ? Colors.amber
                        : Colors.black,
                    width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(width * 0.024),
              child: Text(
                comm.comm,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              padding: EdgeInsets.fromLTRB(
                  width * 0.36, width * 0.012, width * 0.012, width * 0.012),
              child: Text(
                DateFormat('yy/MM/dd  HH:mm')
                    .format(DateTime.parse(comm.comm_time)),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class buildMy_Comments extends StatelessWidget {
  const buildMy_Comments({
    super.key,
    required this.widget,
    required this.comm,
    required this.width,
    required this.height,
  });

  final DebateScreen widget;
  final Comment comm;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              padding: EdgeInsets.all(width * 0.012),
              child: Text(
                comm.uname,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              decoration: BoxDecoration(
                border: Border.all(
                    color: widget.prob.uid == comm.makerID
                        ? Colors.green
                        : Colors.black,
                    width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(width * 0.024),
              child: Text(
                comm.comm,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: width * 0.7),
              padding: EdgeInsets.fromLTRB(
                  width * 0.36, width * 0.012, width * 0.012, width * 0.012),
              child: Text(
                DateFormat('yy/MM/dd  HH:mm')
                    .format(DateTime.parse(comm.comm_time)),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(right: width * 0.024)),
      ],
    );
  }
}
