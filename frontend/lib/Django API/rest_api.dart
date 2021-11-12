import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:life_debugger/data/Location.dart';
import 'package:life_debugger/data/ProblemObj.dart';
import 'package:life_debugger/data/User.dart';
import 'package:life_debugger/data/album.dart';

String apiBase="http://ec2-3-84-12-223.compute-1.amazonaws.com:8000/api/";
/*Future<LocationData?> fetchLocation() async {
  final response = await http
      .get(Uri.parse('https://freegeoip.app/json/'));
  if (response.statusCode == 200) {
    return LocationData.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}*/
Future<LocationData?> fetchLocation(String pin) async {
  final response = await http
      .get(Uri.parse('http://www.postalpincode.in/api/pincode/'+pin));
  if (response.statusCode == 200 && jsonDecode(response.body)["Status"]=="Success") {
    return LocationData.fromJson(jsonDecode(response.body)["PostOffice"][0]);
  } else {
    return null;
  }
}


Future<User?> fetchUser(String username, String password) async {
  User? fetched;
  await http.post(
    Uri.parse(apiBase+'login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password
    }),
  ).then((dynamic response){
    if(response.statusCode==200){
      fetched=User.fromJson(jsonDecode(response.body));
    }
  });
  return fetched;
}


Future<String> createUser(User newUser) async {
  String resp="failed";
    await http.post(
    Uri.parse(apiBase+'createuser'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String,dynamic>{
      "password": newUser.password,
      "email": newUser.email,
      "name": newUser.name,
    }),
  ).then((dynamic response){
      if(response.statusCode==200){
        resp="ok";
      }
  });
  return resp;
}

String createStatus(Map<String, dynamic> json) {
  return json["status"];
}

Future<List<ProblemObj>?> getProblemsList(int type,String location) async {
  List<ProblemObj>? fin;
  String endpt="";
  if(type==0)
    endpt=apiBase+"problems";
  else if(type==1)
    endpt=apiBase+"problems/state/"+location;
  else
    endpt=apiBase+"problems/city/"+location;

  await http.get(
      Uri.parse(endpt),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },

  ).then((dynamic res) {
    try {
      if (res.statusCode == 200) {
        fin = getProblemList(jsonDecode(res.body));
      }
    }
    catch(e){
      fin=[];
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
void updateProblem(ProblemObj prob,int changeUp,int changeDown) async{
  bool resp=false;
  await http.put(
    Uri.parse(apiBase+'update/'+prob.problemId.toString()),
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
      "upvote_count": changeUp,
      "downvote_count": changeDown,
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
    Uri.parse(apiBase+"problems"),
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
      "summary":prob.summary,
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