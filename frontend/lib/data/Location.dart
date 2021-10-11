class LocationData{
  String state;
  String city;
  dynamic locDat;
  LocationData({required this.state,required this.city,this.locDat});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    print(json);
    return LocationData(
      state: json["region_name"],
      city: json["city"],
      locDat: json,
    );
  }

}