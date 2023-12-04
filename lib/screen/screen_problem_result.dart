import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_test/model/api_adapter.dart';
import 'dart:convert';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/model/model_answer.dart';
import 'package:quiz_app_test/screen/screen_create_problem.dart';
import 'package:quiz_app_test/screen/screen_debate.dart';
import 'package:quiz_app_test/screen/screen_home.dart';

class ResultProblemPage extends StatefulWidget {
  Problem prob;
  int selected_ans;

  ResultProblemPage({required this.prob, required this.selected_ans});

  @override
  _ResultProblemPageState createState() => _ResultProblemPageState();
}

class _ResultProblemPageState extends State<ResultProblemPage> {
  bool isButtonActive = false;

  List<Answer> cur_ans = [];
  late Future f;

  Future _fetchAns() async {
    final response = await http.get(
        Uri.http('13.209.70.215:8000', '/quiz/detail/${widget.prob.pno}/'));

    if (response.statusCode == 200) {
      cur_ans = parseAns(utf8.decode(response.bodyBytes));
      if (widget.prob.pstate == 0) {
        _updateCnt();
      }
    } else {
      throw Exception('faild to load data');
    }
  }

  _updateCnt() async {
    int check = 0;
    if (widget.selected_ans.toString() == cur_ans[0].ans_num)
      check = 1;
    else
      check = 0;

    final response = await http.get(
      Uri.http('13.209.70.215:8000',
          '/quiz/update/cnt/${widget.prob.pno}/${check.toString()}/'),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('faild to post data');
    }
  }

  _update(String url) async {
    final response = await http.get(
      Uri.http('13.209.70.215:8000', url),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('faild to post data');
    }
  }

  @override
  void initState() {
    f = _fetchAns();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
          child: FutureBuilder(
              future: f,
              builder: (context, snapshot) {
                //로딩
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                //error
                else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  );
                }
                // 실행
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Problem",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: height * 0.15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView(
                          children: [
                            Text(
                              widget.prob.problem_explain[0],
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Answer",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        constraints: BoxConstraints(maxHeight: height * 0.3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView(
                          children: [
                            for (int i = 1; i < 5; i++)
                              if (widget.prob.problem_explain[i].isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color:
                                            (i == int.parse(cur_ans[0].ans_num))
                                                ? Colors.blue
                                                : Colors.black),
                                  ),
                                  child: Text(
                                    "${i}. " + widget.prob.problem_explain[i],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            (i == int.parse(cur_ans[0].ans_num))
                                                ? Colors.blue
                                                : Colors.black),
                                  ),
                                ),
                          ],
                        ),
                      ),
                      Text(
                        "Explain",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        constraints: BoxConstraints(maxHeight: height * 0.3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(width * 0.024,
                                  width * 0.024, width * 0.024, 0),
                              child: Text(
                                cur_ans[0].ans_explain,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              if (isButtonActive == false &&
                                  widget.prob.pstate == 0) {
                                _update(
                                    '/quiz/update/like/${widget.prob.pno}/');
                                setState(() {
                                  isButtonActive = true;
                                });
                              }
                            },
                            icon: Icon(Icons.thumb_up),
                            label: Text(
                              "like",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: Size(width * 0.25, height * 0.05),
                              backgroundColor:
                                  isButtonActive ? Colors.red : Colors.grey,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (widget.prob.pstate == 0) {
                                _update(
                                    '/quiz/update/pstate/${widget.prob.pno}/');
                                widget.prob.pstate = 1;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DebateScreen(prob: widget.prob)));
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: Size(width * 0.25, height * 0.05),
                            ),
                            child: Text(
                              "Debate",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate back to the home screen
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                  (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: Size(width * 0.25, height * 0.05),
                            ),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              })),
    );
  }
}
