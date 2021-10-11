class Album {
  final String prob;
  final String desc;
  final String location;

  Album({
    required this.prob,
    required this.desc,
    required this.location,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      prob: json["problem_id"],
      desc: json["description"],
      location: json["location"],
    );
  }
}