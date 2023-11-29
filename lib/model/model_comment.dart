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
