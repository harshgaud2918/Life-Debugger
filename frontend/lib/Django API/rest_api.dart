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
    Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/'),
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
  final response = await http.post(
    Uri.parse('http://ec2-100-26-104-31.compute-1.amazonaws.com:8000/api/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'location': location,
    }),
  );

  if (response.statusCode == 201) {
    return getProblemList(jsonDecode(response.body));
  } else {
    return null;
  }
}

List<ProblemObj> getProblemList(Map<String, dynamic> json){
  return json["list"];
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