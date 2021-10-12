

import 'Location.dart';

class ProblemObj{
  int problemId;
  String summary;
  String description;
  String? category;
  LocationData? location;
  int valid,invalid;
  int severity;
  int userId;
  List<String>? tags=[];
  String url;
  ProblemObj({
    required this.problemId,
    required this.summary,
    required this.description,
    required this.location,
    required this.valid,
    required this.invalid,
    required this.userId,
    required this.severity,
    this.category,
    this.tags,
    required this.url
  });
  factory ProblemObj.fromJson(Map<String, dynamic> json) {
    return ProblemObj(
      problemId: json['id'],
      summary: " ",
      description: json['description'],
      location: LocationData(state: "9",city: "0"),//LocationData(city: json['location']['city'],state: json['location']['state']),
      valid: json['upvote_count'],
      invalid: json['downvote_count'],
      userId: json['user'],
      severity: json['severity'],
      url: json['picture_url'],
    );
  }
}