

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
  //String url="https://img.stickers.cloud/packs/58c037f4-8700-40bb-97ef-b6a6ee0ff398/png/a8efe763-c280-43d3-a03b-3f49bc41ac57.png";
  //String image="https://i1.wp.com/leanprojectplaybook.com/wp-content/uploads/2017/07/Problem-Solution-Fit-64922822_xxl-Puzzle-Piece-e1499237044963.jpg?resize=1030%2C438";
  //https://drive.google.com/file/d/1SsNVRNYDriv-NCXD0YnLRUlSFJynRcWi/view?usp=sharing
  String? url;
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
    this.url
  });
}