class loginUser {
  String? id;
  String? pwd;
  int? upoint;
  String? uname;
  String? email;

  loginUser({this.id, this.pwd, this.upoint, this.uname, this.email});

  Map<String, dynamic> toJson() =>
      {"id": id, "pwd": pwd, "upoint": upoint, "uname": uname, "email": email};
}
