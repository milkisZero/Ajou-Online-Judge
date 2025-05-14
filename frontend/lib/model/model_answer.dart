class Answer {
  String ans_num;
  String ans_explain;

  Answer(this.ans_num, this.ans_explain);

  Answer.fromJson(Map<String, dynamic> json)
      : ans_num = json['answer'],
        ans_explain = json['ans_explain'];

  Map<String, dynamic> toJson() => {
        "answer": ans_num,
        "ans_explain": ans_explain,
      };
}
