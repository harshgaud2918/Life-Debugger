class User{
  int userId;
  String name;
  String email;
  String profilePicURL="https://cdn141.picsart.com/279537722049211.png?r1024x1024";
  String phoneNumber;
  String password="";
  List<int> upVoteList=[];
  List<int> downVoteList=[];
  bool mod=true;

  User({required this.userId,required this.name,required this.email,required this.phoneNumber,required this.mod,required this.upVoteList,required this.downVoteList,required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      password: json['password'],
      name: json["username"],
      email: json["email"],
      phoneNumber:"6969696969",// json["phoneNumber"],
      upVoteList: json["upvote_list"]==null?[]:json["upvote_list"],
      downVoteList: json["downvote_list"]==null?[]:json["downvote_list"],
      mod: json["is_superuser"],
    );
  }
}

