import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/models/place_details_model/place_details_model.dart';
import 'package:graduation_application/models/places_autocomplete_model/places_autocomplete_model.dart';
import 'package:graduation_application/utils/google_maps_place_service.dart';

class CustomPlacesList extends StatelessWidget {
  const CustomPlacesList({
    super.key,
    required this.places,
    required this.placesService,
    required this.onPlaceSelect,
  });

  final List<PlacesAutocompleteModel> places;
  final PlacesService placesService;
  final void Function(PlaceDetailsModel) onPlaceSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: kTextFieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              FontAwesomeIcons.mapPin,
            ),
            trailing: IconButton(
              onPressed: () async {
                var placeDetails = await placesService.getPlaceDetails(
                  placeId: places[index].placeId.toString(),
                  sessionToken: '',
                );
                onPlaceSelect(placeDetails);
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
            title: Text(places[index].description!),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
        itemCount: places.length,
      ),
    );
  }
}
