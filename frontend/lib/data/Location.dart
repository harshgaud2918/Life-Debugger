class LocationData{
  String state;
  String city;
  dynamic locDat;
  LocationData({required this.state,required this.city,this.locDat});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      state: json["State"].toString().trim(),
      city: json["Region"].toString().trim(),
      locDat: json,
    );
  }
  factory LocationData.fromAPIJson(Map<String, dynamic> json) {
    return LocationData(
      state: json["State"].toString().trim(),
      city: json["City"].toString().trim(),
      locDat: json,
    );
  }

}