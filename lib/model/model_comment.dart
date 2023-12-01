class Comment {
  int pno;
  String makerID;
  String uname;
  String comm;
  String comm_time;

  Comment(this.pno, this.uname, this.makerID, this.comm, this.comm_time);

  Comment.fromJson(Map<String, dynamic> json)
      : pno = json['pno'],
        makerID = json['maker_id'],
        uname = json['uname'],
        comm = json['comm'],
        comm_time = json['comm_time'];

  Map<String, dynamic> toJson() => {
        "pno": pno,
        "maker": makerID,
        "uname": uname,
        "comm": comm,
        "comm_time": comm_time,
      };
}
