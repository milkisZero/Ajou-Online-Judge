import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';

String? selected;
int? sub_id;
final subjects = [
  "Algorithm",
  "Database",
  "Software\nEngineering",
  "Computer\nArchitecture",
  "Data\nStructure",
  "Linear\nAlgebra",
  "Operating\nSystem"
];

class ProblemInfoFormData {
  int? Pno;
  int? Sub_id;
  String? maker_id;
  int? Plike;
  int? Pstate;
  String? Ptime;
  int? TryCnt;
  int? AcCnt;

  ProblemInfoFormData(
      {this.Pno,
      this.Sub_id,
      this.maker_id,
      this.Plike,
      this.Pstate,
      this.Ptime,
      this.TryCnt,
      this.AcCnt});

  Map<String, dynamic> toJson() => {
        "pno": Pno,
        "sub": Sub_id,
        "maker": maker_id,
        "plike": Plike,
        "pstate": Pstate,
        "ptime": Ptime,
        "trycnt": TryCnt,
        "accnt": AcCnt,
      };
}

class ProblemContentFormData {
  int? Pno;
  String? problem_explain;
  String? answer;
  String? ans_explain;

  ProblemContentFormData(
      {this.Pno, this.problem_explain, this.answer, this.ans_explain});

  Map<String, dynamic> toJson() => {
        "pno": Pno,
        "problem_explain": problem_explain,
        "answer": answer,
        "ans_explain": ans_explain,
      };
}

class CreateProblemPage extends StatefulWidget {
  @override
  _CreateProblemPageState createState() => _CreateProblemPageState();
}

class _CreateProblemPageState extends State<CreateProblemPage> {
  List<bool> isSelected = List.generate(4, (index) => false);
  List<TextEditingController> choiceControllers =
      List.generate(4, (index) => TextEditingController());

  TextEditingController titleController = TextEditingController();
  TextEditingController answerExplainController = TextEditingController();
  ProblemInfoFormData infoData = ProblemInfoFormData();
  ProblemContentFormData contData = ProblemContentFormData();

  int numberOfChoices = 4; // 초기값: 4
  int selectedChoice = -1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    initState() {
      super.initState();
      setState(() {
        numberOfChoices = 4; // 초기값: 4
        selectedChoice = -1;
        selected = null;
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(width * 0.024)),
                    Text(
                      'Create Problem',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(width * 0.024)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side: BorderSide(color: Colors.black, width: 2),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fixedSize: Size(width * 0.3, height * 0.091),
                          ),
                          onPressed: () {
                            setState(() {
                              // Toggle between 4 and 2 choices
                              numberOfChoices = (numberOfChoices == 4) ? 2 : 4;
                              choiceControllers = List.generate(
                                numberOfChoices,
                                (index) => TextEditingController(),
                              );
                            });
                          },
                          child: Text(
                            '${numberOfChoices}지선다',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Material(
                          elevation: 0,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
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
                                        fontSize: 20,
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
                                    sub_id =
                                        subjects.indexOf(selected.toString()) +
                                            1;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(width * 0.024)),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Problem Context',
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 40),
                Text(
                  'Check the Answer',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                ...List.generate(
                  numberOfChoices,
                  (index) => Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedChoice =
                                selectedChoice == index ? -1 : index;
                          });
                        },
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedChoice == index
                                  ? Colors.blue
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: selectedChoice == index
                                ? Icon(Icons.check, color: Colors.blue)
                                : SizedBox.shrink(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: choiceControllers[index],
                          decoration: InputDecoration(
                            labelText: 'Choice ${index + 1}',
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: answerExplainController,
                  decoration: InputDecoration(
                    labelText: 'Write down the explanation of the answer',
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: selectedChoice != -1
                      ? () {
                          addProblemToServer();
                        }
                      : null,
                  child: Text('Create'),
                ),
              ],
            ),
          ),
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
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void addProblemToServer() async {
    final getpnum =
        await http.get(Uri.http('13.209.70.215:8000', 'quiz/get/pnum/'));

    infoData.Pno = int.parse(getpnum.body);
    infoData.Sub_id = sub_id;
    infoData.maker_id = Provider.of<loginUser>(context, listen: false).id;
    infoData.Plike = 0;
    infoData.Pstate = 0;
    infoData.TryCnt = 0;
    infoData.Ptime = DateTime.now().toUtc().toIso8601String();
    infoData.AcCnt = 0;

    String contextAndChoice = "";
    contextAndChoice += titleController.text;
    for (int i = 0; i < numberOfChoices; i++) {
      contextAndChoice += "?>";
      contextAndChoice += choiceControllers[i].text;
    }

    contData.Pno = int.parse(getpnum.body);
    contData.problem_explain = contextAndChoice;
    contData.answer = (selectedChoice + 1).toString();
    contData.ans_explain = answerExplainController.text;

    final infoResponse = await http.post(
      Uri.http('13.209.70.215:8000', 'quiz/make/pi/'),
      headers: {'content-type': 'application/json'},
      body: json.encode(infoData),
    );

    final contResponse = await http.post(
      Uri.http('13.209.70.215:8000', 'quiz/make/pc/'),
      headers: {'content-type': 'application/json'},
      body: json.encode(contData),
    );

    if (infoResponse.statusCode == 201 && contResponse.statusCode == 201)
      _showDialog('Successfully create Problem!');
    else
      _showDialog('Failed to create Problem');

    setState(() {
      numberOfChoices = 4; // 초기값: 4
      selectedChoice = -1;
      selected = null;
    });
  }
}
