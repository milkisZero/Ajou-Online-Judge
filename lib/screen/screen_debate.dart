import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_comment.dart';
import 'package:quiz_app_test/model/model_loginUser.dart';
import 'package:quiz_app_test/model/model_probelm.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:quiz_app_test/widget/widget_comment_list.dart';

class DebateScreen extends StatefulWidget {
  DebateScreen({required this.prob});

  final Problem prob;

  @override
  State<DebateScreen> createState() => _DebateScreenState();
}

class _DebateScreenState extends State<DebateScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool text_exist = false;
  List<Comment> comments = [];

  _postComment(Comment comm) async {
    final response = await http.post(
      Uri.http('13.209.70.215:8000', '/quiz/make/comm/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(comm),
    );

    if (response.statusCode == 201) {
      await _fetchComment();
    } else {
      throw Exception('faild to post data');
    }
  }

  _fetchComment() async {
    final response = await http
        .get(Uri.http('13.209.70.215:8000', '/quiz/comm/${widget.prob.pno}/'));

    if (response.statusCode == 200) {
      comments.clear();
      comments = parseComm(utf8.decode(response.bodyBytes));

      setState(() {});
    } else {
      throw Exception('faild to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComment();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    loginUser login_user = Provider.of<loginUser>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              child: ListView(
                reverse: true,
                children: [
                  for (Comment comm in comments)
                    Column(
                      children: [
                        comm.makerID == login_user.id
                            ? buildMy_Comments(
                                widget: widget,
                                comm: comm,
                                width: width,
                                height: height)
                            : buildComments(
                                widget: widget,
                                comm: comm,
                                width: width,
                                height: height),
                        Padding(
                            padding: EdgeInsets.only(bottom: width * 0.048)),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              child: TextField(
                controller: _textEditingController,
                onChanged: (text) {
                  setState(() {
                    text_exist = true;
                  });
                },
                onSubmitted: text_exist ? _submmitMsg : null,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30,
                    ),
                    onPressed: text_exist
                        ? () => {_submmitMsg(_textEditingController.text)}
                        : null,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submmitMsg(String text) {
    _textEditingController.clear();
    setState(() {
      text_exist = false;
    });

    _postComment(Comment(
        widget.prob.pno,
        Provider.of<loginUser>(context, listen: false).uname.toString(),
        Provider.of<loginUser>(context, listen: false).id.toString(),
        text,
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())));
  }
}
