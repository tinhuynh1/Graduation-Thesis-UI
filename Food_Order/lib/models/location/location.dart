class Location {
  double lat;
  double lng;
  Location({this.lat, this.lng});

  @override
  String toString() {
    return 'Location(lat: $lat, lng: $lng)';
  }

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}
