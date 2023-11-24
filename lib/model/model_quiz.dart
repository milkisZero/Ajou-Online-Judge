class Quiz {
  String title;
  List<String> candidates;
  int answer;

  Quiz(this.title, this.candidates, this.answer);

  Quiz.framMap(Map<String, dynamic> map)
      : title = map['title'],
        candidates = map['candidate'],
        answer = map['answer'];

  Quiz.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        candidates = json['body'].toString().split('/'),
        answer = json['answer'];
}

class ProbelmInfo {
  String ptime;
  int pno;
  int plike;
  int pstate;
  int upoint;
  String uname;
  String sname;
  int sid;
  List<String> problem_explain; //

  ProbelmInfo(this.ptime, this.pno, this.plike, this.pstate, this.upoint,
      this.uname, this.sname, this.sid, this.problem_explain);

  ProbelmInfo.framMap(Map<String, dynamic> map)
      : ptime = map['ptime'],
        pno = map['pno'],
        plike = map['plike'],
        pstate = map['pstate'],
        upoint = map['upoint'],
        uname = map['uname'],
        sname = map['sname'],
        sid = map['sid'],
        problem_explain = map['problem_explain'];

  ProbelmInfo.fromJson(Map<String, dynamic> json)
      : ptime = json['ptime'],
        pno = json['pno'],
        plike = json['plike'],
        pstate = json['pstate'],
        upoint = json['upoint'],
        uname = json['uname'],
        sname = json['sname'],
        sid = json['sid'],
        problem_explain = json['problem_explain'].toString().split("?>");
}

class Comment {
  int pno;
  String maker;
  String comm;
  String comm_time;

  Comment(this.pno, this.maker, this.comm, this.comm_time);

  Map<String, dynamic> toJson() => {
        "pno": pno,
        "maker": maker,
        "comm": comm,
        "comm_time": comm_time,
      };
}
