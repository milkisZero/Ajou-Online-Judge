import 'package:flutter/material.dart';
import 'package:quiz_app_test/api_adapter.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_create_problem.dart';
import 'package:quiz_app_test/screen/screen_solve.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quiz_app_test/widget/widget_home_list.dart';
import 'package:quiz_app_test/widget/widget_usericon.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;
  List<Problem> problems = [];
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

    if (response.statusCode == 200) {
      problems.clear();
      problems = parseProbs(utf8.decode(response.bodyBytes));
      isLoading = false;

      print("200");
      if (problems.isEmpty) {
        page_num -= 1;
        if (selected != null)
          _fetchProbelm("/quiz/subj/${sub_id}/${page_num}/");
        else
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    Provider.of<loginUser>(context).fetchPoint();

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
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
                        elevation: 0,
                        side: BorderSide(color: Colors.black, width: 2),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(width * 0.2, width * 0.1),
                      ),
                      onPressed: () {
                        sort_by = 0;
                        page_num = 0;
                        selected = null;
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
                        elevation: 0,
                        side: BorderSide(color: Colors.black, width: 2),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(width * 0.2, width * 0.1),
                      ),
                      onPressed: () {
                        sort_by = 1;
                        page_num = 0;
                        selected = null;
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
                      elevation: 0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            child: DropdownButton(
                              elevation: 8,
                              borderRadius: BorderRadius.circular(20),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              dropdownColor: Colors.white,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProblemPage()));
                      },
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: width * 0.15,
                        padding: EdgeInsets.all(width * 0.012),
                        child: widget_usericon(
                            upoint:
                                Provider.of<loginUser>(context, listen: false)
                                        .upoint ??
                                    0)),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(bottom: width * 0.024)),
                        Text(
                          "USER NAME : " +
                              Provider.of<loginUser>(context, listen: false)
                                  .uname
                                  .toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: width * 0.024)),
                        Text(
                          "USER POINT : " +
                              Provider.of<loginUser>(context, listen: false)
                                  .upoint
                                  .toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    for (Problem pro in problems)
                      Column(
                        children: [
                          // Padding(
                          //     padding: EdgeInsets.only(bottom: width * 0.024)),
                          build_home_list(
                              context: context, width: width, prob: pro),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 2),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: Size(width * 0.2, width * 0.1),
                            ),
                            onPressed: () {
                              if (page_num > 0) {
                                page_num -= 1;
                                problems.clear();
                                selected == null
                                    ? _fetchProbelm(
                                        '/quiz/all/${page_num}/${sort_by}')
                                    : _fetchProbelm(
                                        "/quiz/subj/${subjects.indexOf(selected.toString()) + 1}/${page_num}/");
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'PREV',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          child: Center(
                              child: Text(
                            (page_num + 1).toString(),
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                        ),
                        Container(
                          width: width * 0.3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              side: BorderSide(color: Colors.black, width: 2),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fixedSize: Size(width * 0.2, width * 0.1),
                            ),
                            onPressed: () {
                              page_num += 1;
                              problems.clear();
                              selected == null
                                  ? _fetchProbelm(
                                      '/quiz/all/${page_num}/${sort_by}')
                                  : _fetchProbelm(
                                      "/quiz/subj/${subjects.indexOf(selected.toString()) + 1}/${page_num}/");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'NEXT',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
