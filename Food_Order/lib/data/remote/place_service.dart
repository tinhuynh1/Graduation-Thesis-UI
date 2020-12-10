import 'dart:convert';
import 'dart:io';

import 'package:Food_Order/models/location/location.dart';
import 'package:Food_Order/models/location/terms.dart';
import 'package:http/http.dart';

class Suggestion {
  final String placeId;
  final String description;
  final List<Terms> temrs;
  Suggestion(this.placeId, this.description, this.temrs);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyBJAGy5XN6RxaHa5E4btSBxsbveOK4dXZA';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=vi&components=country:vn&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(
                p['place_id'],
                p['description'],
                p['terms']
                    .map<Terms>((t) => Terms(t['offset'], t['value']))
                    .toList()))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Location> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result['status'] == 'OK') {
        final location =
            Location.fromJson(result['result']['geometry']['location']);
        print(location.toString());

        return location;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
