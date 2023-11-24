import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_solve.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;
  List<ProbelmInfo> problems = [];
  int page_num = 0;

  _fetchProbelm() async {
    isLoading = true;
    final response = await http
        .get(Uri.http('13.209.70.215:8000', '/quiz/all/${page_num}/0'));

//    Comment comm = Comment(30, "user123", "데이터베이스는 재미있어", "2023-11-15T22:45:30");

    // Map map = {
    //   "pno": 30,
    //   "maker": "user123",
    //   "comm": "테스트입니다",
    //   "comm_time": "2023-11-15T22:45:30",
    // };

    // final body = json.encode(comm);

    // final response =
    //     await http.post(Uri.http('13.209.70.215:8000', '/quiz/make/comm/'),
    //         headers: <String, String>{
    //           'Content-Type': 'application/json',
    //         },
    //         body: body);

    if (response.statusCode == 200) {
      problems.clear();
      problems = parseProbs(utf8.decode(response.bodyBytes));
      isLoading = false;

//    print(page_num);
      print("200");
      if (problems.isEmpty) {
        page_num -= 1;
        _fetchProbelm();
      } else {
        var controller = PrimaryScrollController.of(context);
        controller?.jumpTo(0);
        setState(() {});
      }
    } else {
      throw Exception('faild to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProbelm();
  }

  // 더미데이터
  // List<ProbelmInfo> problems = [
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹sdfsfsdfsdfsdfsdfs',
  //     'sname': '알고flwmadfsdfsfsf',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹',
  //     'sname': '알고',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹',
  //     'sname': '알고',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹',
  //     'sname': '알고',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹',
  //     'sname': '알고',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  //   ProbelmInfo.framMap({
  //     'ptime': DateTime.parse('2022-11-22 15:45:45'),
  //     'pno': 1,
  //     'plike': 123,
  //     'pstate': 0,
  //     'upoint': 1122,
  //     'uname': '킹',
  //     'sname': '알고',
  //     'problem_explain':
  //         'ㄴㅇㄹㄴㄹㄴㄹㄴㅇㄹㄴㄴㅇㄹ\nfdfdfdfsfsdfsfsdfsfsfsfssfsddddddddddddddddddddddddddddddddddddddddddddddddddddddddddfsdf',
  //   }),
  // ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double hight = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Center(child: const Text("DB Quiz App")),
            backgroundColor: Colors.deepPurple,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'MYPAGE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'SETTING',
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              for (ProbelmInfo pro in problems)
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: width * 0.024)),
                    _buildStep(width, pro),
                  ],
                ),
              Padding(padding: EdgeInsets.only(bottom: width * 0.024)),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.5, width * 0.12),
                      ),
                      onPressed: () {
                        if (page_num > 0) {
                          page_num -= 1;
                          problems.clear();
                          _fetchProbelm();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BEFORE',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.navigate_before,
                            size: width * 0.1,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.1,
                    child: Center(
                        child: Text(
                      (page_num + 1).toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 0.5, width * 0.12),
                      ),
                      onPressed: () {
                        page_num += 1;
                        problems.clear();
                        _fetchProbelm();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.navigate_next,
                            size: width * 0.1,
                          ),
                          Text(
                            'NEXT',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: width * 0.036),
                //   child: Center(
                //     child: ButtonTheme(
                //       minWidth: screenWidth * 0.8,
                //       height: screenHight * 0.05,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: ElevatedButton(
                //           onPressed: () {
                //             _scaffoldKey.currentState?.showSnackBar(
                //               SnackBar(
                //                 content: Row(
                //                   children: <Widget>[
                //                     CircularProgressIndicator(),
                //                     Padding(
                //                       padding: EdgeInsets.only(
                //                           left: screenWidth * 0.036),
                //                     ),
                //                     Text('로딩 중...'),
                //                   ],
                //                 ),
                //               ),
                //             );

                // _fetchQuizs().whenComplete(() {
                //   return Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               QuizScreen(quizs: quizs)));
                // });
                //           },
                //           child: Text(
                //             '지금 퀴즈풀기',
                //             style: TextStyle(color: Colors.white),
                //           ),
                //           style: ElevatedButton.styleFrom(
                //               backgroundColor: Colors.deepPurple)),
                //     ),
                //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(double width, ProbelmInfo prob) {
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
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                        text: prob.problem_explain[0],
                        style: TextStyle(fontSize: 19, color: Colors.black)),
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
