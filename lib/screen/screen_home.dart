import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_solve.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quiz_app_test/widget/widget_home_list.dart';

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
  int sort_by = 0;

  final subjects = [
    "Algorithm",
    "Database",
    "Software\nEngineering",
    "Computer\nArchitecture",
    "Data\nStructure",
    "Linear\nAlgebra",
    "Operating\nSystem"
  ];
  String? selected;

  _fetchProbelm(String url) async {
    isLoading = true;
    final response = await http.get(Uri.http('13.209.70.215:8000', url));

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

      print("200");
      if (problems.isEmpty) {
        page_num -= 1;
        _fetchProbelm('/quiz/all/${page_num}/${sort_by}');
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
    _fetchProbelm('/quiz/all/${page_num}/${sort_by}');
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
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.grey,
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
          body: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: width * 0.024)),
              SizedBox(
                height: height * 0.08,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(right: width * 0.024)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(width * 0.2, width * 0.1),
                      ),
                      onPressed: () {
                        sort_by = 0;
                        page_num = 0;
                        selected = "";
                        problems.clear();
                        _fetchProbelm('/quiz/all/${page_num}/${sort_by}');
                      },
                      child: Text(
                        "최신순",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.024)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(width * 0.2, width * 0.1),
                      ),
                      onPressed: () {
                        sort_by = 1;
                        page_num = 0;
                        selected = "";
                        problems.clear();
                        _fetchProbelm('/quiz/all/${page_num}/${sort_by}');
                      },
                      child: Text(
                        "추천순",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.024)),
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            //    alignedDropdown: true,
                            child: DropdownButton(
                              elevation: 8,
                              borderRadius: BorderRadius.circular(20),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              dropdownColor: Colors.lightBlue.shade50,
                              alignment: AlignmentDirectional.center,
                              hint: Text(
                                "과목순",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              value: selected,
                              items: subjects
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                selected = value;
                                page_num = 0;
                                sort_by = 0;
                                int sub_id =
                                    subjects.indexOf(selected.toString()) + 1;
                                _fetchProbelm(
                                    "/quiz/subj/${sub_id}/${page_num}/");
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.012)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        fixedSize: Size(width * 0.1, width * 0.1),
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.add_circle_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.024)),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: width * 0.024)),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    for (ProbelmInfo pro in problems)
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: width * 0.024)),
                          build_home_list(
                              context: context, width: width, prob: pro),
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
                                _fetchProbelm(
                                    '/quiz/all/${page_num}/${sort_by}');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BEFORE',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                              _fetchProbelm('/quiz/all/${page_num}/${sort_by}');
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
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
