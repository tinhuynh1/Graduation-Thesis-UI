class Suggestion {
  String placeId;
  String description;

  Suggestion({this.placeId, this.description});
  static List<Suggestion> parseSuggestionList(map) {
    var list = map['predictions'] as List;
    return list.map((suggestion) => Suggestion.fromJson(suggestion)).toList();
  }

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }

  factory Suggestion.fromJson(Map<String, dynamic> map) => Suggestion(
        placeId: map["place_id"],
        description: map["description"],
      );
}
