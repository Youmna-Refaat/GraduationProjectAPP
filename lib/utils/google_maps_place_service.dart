import 'dart:convert';
import 'package:graduation_application/models/place_details_model/place_details_model.dart';
import 'package:graduation_application/models/places_autocomplete_model/places_autocomplete_model.dart';
import 'package:http/http.dart' as http;

class PlacesService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyBuEQii4BSyQaJoXyeqIFw_fs7m2QDPfjI';
  Future<List<PlacesAutocompleteModel>> getPredictions(
      {required String input, required String sessionToken}) async {
    var response = await http.get(Uri.parse(
        '$baseUrl/autocomplete/json?key=$apiKey&input=$input&sessiontoken=$sessionToken'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['predictions'];
      List<PlacesAutocompleteModel> places = [];
      for (var item in data) {
        places.add(PlacesAutocompleteModel.fromJson(item));
      }
      return places;
    } else {
      throw Exception();
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails(
      {required String placeId, required String sessionToken}) async {
    var response = await http.get(Uri.parse(
        '$baseUrl/details/json?key=$apiKey&place_id=$placeId&sessiontoken=$sessionToken'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];

      return PlaceDetailsModel.fromJson(data);
    } else {
      throw Exception();
    }
  }
}
