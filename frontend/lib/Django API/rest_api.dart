import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/data/album.dart';


Future<LocationData?> fetchLocation() async {
  final response = await http
      .get(Uri.parse('https://freegeoip.app/json/'));
  if (response.statusCode == 200) {
    return LocationData.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/'));
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User');
  }
}


Future<String> createUser(User newUser) async {
  final response = await http.post(
    //Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/'),
    Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/admin/api/user/add/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, User>{
      'user': newUser,
    }),
  );

  if (response.statusCode == 201) {
    return createStatus(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

String createStatus(Map<String, dynamic> json) {
  return json["status"];
}

Future<List<ProblemObj>?> getProblemsList(String location) async {
  List<ProblemObj>? fin;
  await http.get(
    Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/problems'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },

  ).then((dynamic res) {
    if (res.statusCode==200) {
     fin = getProblemList(jsonDecode(res.body));
    }
  });
  return fin;
}

List<ProblemObj> getProblemList(dynamic dict){
  List<ProblemObj> fin=[];
  for(dynamic i in dict){
    fin.add(ProblemObj.fromJson(i));
  }
  return fin;

}
void updateProblem(ProblemObj prob) async{
  bool resp=false;
  await http.put(
    Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/update/'+prob.problemId.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String,dynamic>{
      "description": prob.description,
      "category": "Disaster",
      "location": {
        "City": prob.location!.city.toString(),
        "State": prob.location!.state.toString()
      },
      "upvote_count": prob.valid,
      "downvote_count": prob.invalid,
      "severity": prob.severity,
      "picture_url": prob.url,
      "user": prob.userId
    }
    ),
  ).then((dynamic response) {
    if(response.statusCode==200){
      resp=true;
    }
  });
  //print(resp);
}
Future<String> createProblem(ProblemObj prob) async {
    String status="0";
    await http.post(
    Uri.parse("http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/problems"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String,dynamic>{
      "description": prob.description,
      "category": "Disaster",
      "location": {
        "City": prob.location!.city.toString(),
        "State": prob.location!.state.toString()
      },
      "upvote_count": prob.valid,
      "downvote_count": prob.invalid,
      "severity": prob.severity,
      "picture_url": prob.url,
      "user": prob.userId
    }),
  ).then((dynamic res) {
      if (res.statusCode==200) {
        status = createProbStatus(jsonDecode(res.body));
      }
  });
    return status;
}

String createProbStatus(Map<String, dynamic> json) {
  return json["message"];
}