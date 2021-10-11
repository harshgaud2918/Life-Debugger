class User{
  int userId;
  String name;
  String email;
  String profilePicURL="https://cdn141.picsart.com/279537722049211.png?r1024x1024";
  String phoneNumber;
  String password;
  List<int> upVoteList=[];
  List<int> downVoteList=[];
  bool mod=true;

  User({required this.userId,required this.name,required this.email,required this.phoneNumber,required this.password,required this.mod,required this.upVoteList,required this.downVoteList});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userID"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      upVoteList: json["upVoteList"],
      downVoteList: json["downVoteList"],
      mod: json["mod"],
    );
  }
}

