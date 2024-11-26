import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/models/place_details_model/place_details_model.dart';
import 'package:graduation_application/models/places_autocomplete_model/places_autocomplete_model.dart';
import 'package:graduation_application/screens/child/safezones_details._user.dart';
import 'package:graduation_application/utils/google_maps_place_service.dart';
import 'package:graduation_application/utils/refactored_location_service.dart';
import 'package:graduation_application/widgets/Buttons/custom_add_safezone_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';
import 'package:graduation_application/widgets/TextFields/distance_text_field.dart';
import 'package:graduation_application/widgets/TextFields/location_text_field.dart';
import 'package:graduation_application/widgets/custom_box.dart';
import 'package:graduation_application/widgets/lists/list_places.dart';
import 'package:uuid/uuid.dart';

class MapForZones extends StatefulWidget {
  const MapForZones({
    super.key,
    required this.onAdd,
  });

  final Function(String, String, int, String) onAdd;

  @override
  State<MapForZones> createState() => _MapForZonesState();
}

class _MapForZonesState extends State<MapForZones> {
  late CameraPosition initialCameraPosition;
  late RefactoredLocationService refactoredLocationService;
  late GoogleMapController googleMapController;
  late TextEditingController tittleController = TextEditingController();

  late TextEditingController locationController = TextEditingController();
  late TextEditingController distanceController = TextEditingController();
  late PlacesService placesService;
  late Uuid uuid;
  String? sessionToken;
  late String location = '', tittle = '';
  late int distance = 0;

  List<CustomBox> childSafezones = [
    CustomBox(
      title: 'Safezone',
      icon: FontAwesomeIcons.trash,
      routingScreen: const ChildSafezonesDetails(
        safezoneId: '',
      ),
      onPressed: () {},
      safezoneId: '',
    )
  ];
  bool isFirstCall = true;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  List<PlacesAutocompleteModel> places = [];
  double radiusValue = 0.0;

  @override
  void initState() {
    super.initState();

    initialCameraPosition = const CameraPosition(
      zoom: 12,
      target: LatLng(26.90097230497843, 30.096924944177502),
    );
    uuid = const Uuid();
    placesService = PlacesService();
    locationController = TextEditingController();
    distanceController = TextEditingController();
    tittleController = TextEditingController();

    refactoredLocationService = RefactoredLocationService();
    fetchPredictions();
    distanceController.addListener(safezoneDistance);
  }

  void safezoneDistance() {
    final String input = distanceController.text;
    try {
      radiusValue = double.parse(input);
    } catch (e) {
      radiusValue = 0.0;
    }
    setState(() {
      if (markers.isNotEmpty) {
        var marker = markers.first;
        circles.clear();
        circles.add(
          Circle(
            circleId: CircleId(marker.markerId.value),
            center: marker.position,
            radius: radiusValue,
            fillColor: kPrimaryColor.withOpacity(0.6),
            strokeWidth: 1,
            strokeColor: Colors.black,
          ),
        );
      }
    });
    places.clear();
  }

  void fetchPredictions() {
    locationController.addListener(() async {
      sessionToken ??= uuid.v4();
      if (locationController.text.isNotEmpty) {
        var result = await placesService.getPredictions(
          input: locationController.text,
          sessionToken: sessionToken!,
        );
        places.clear();
        places.addAll(result);
        setState(() {});
      } else {
        places.clear();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    googleMapController.dispose();
    locationController.dispose();
    distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              left: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: 'Enter Safezone title',
                  radius: 15,
                  title: 'Safezone title',
                  width: 300,
                  height: 30,
                  textColor: kHintTextColor,
                  hintTextColor: kTextColor,
                  backgroundColor: kPrimaryColor.withOpacity(0.7),
                  textEditingController: tittleController,
                ),
                const SizedBox(height: 10),
                Text(
                  'Location',
                  style: GoogleFonts.roboto(
                    textStyle:
                        const TextStyle(color: kHintTextColor, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 5),
                LocationTextField(textEditingController: locationController),
                const SizedBox(height: 3),
                if (places.isNotEmpty)
                  CustomPlacesList(
                    places: places,
                    placesService: placesService,
                    onPlaceSelect: (placeDetailsModel) {
                      onPlaceSelected(placeDetailsModel);
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distance by meters',
                  style: GoogleFonts.roboto(
                    textStyle:
                        const TextStyle(color: kHintTextColor, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 5),
                DistanceTextField(distanceController: distanceController),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: CustomAddSafezoneButton(
                    text: 'Add',
                    width: 200,
                    height: 50,
                    radius: 10,
                    locationController: locationController,
                    distanceController: distanceController,
                    tittleController: tittleController,
                    addCustomBox: (String id, String location, int distance,
                        String tittle) {
                      widget.onAdd(id, location, distance, tittle);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            width: 410,
            color: kTextFieldColor,
            child: GoogleMap(
              circles: circles,
              markers: markers,
              onMapCreated: (controller) {
                googleMapController = controller;
                initMapStyle();
              },
              initialCameraPosition: initialCameraPosition,
            ),
          )
        ],
      ),
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night.json');
    googleMapController.setMapStyle(nightMapStyle);
  }

  void onPlaceSelected(PlaceDetailsModel placeDetails) async {
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/marker.png');
    markers.clear();
    var selectedPlaceMarker = Marker(
      icon: customMarkerIcon,
      markerId: MarkerId(placeDetails.placeId!),
      position: LatLng(placeDetails.geometry!.location!.lat!,
          placeDetails.geometry!.location!.lng!),
      infoWindow: InfoWindow(title: placeDetails.name),
    );
    markers.add(selectedPlaceMarker);
    CameraPosition newPosition = CameraPosition(
      target: LatLng(placeDetails.geometry!.location!.lat!,
          placeDetails.geometry!.location!.lng!),
      zoom: 14,
    );
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newPosition));
    places.clear();
    sessionToken = null;
    initCircles(placeDetails);

    setState(() {});
  }

  void initCircles(PlaceDetailsModel placeDetails) {
    var myCircle = Circle(
      circleId: CircleId(placeDetails.placeId.toString()),
      center: LatLng(placeDetails.geometry!.location!.lat!,
          placeDetails.geometry!.location!.lng!),
      radius: radiusValue,
      fillColor: const Color.fromARGB(169, 72, 166, 220),
      strokeWidth: 2,
      strokeColor: Colors.black,
    );
    circles.add(myCircle);
    setState(() {});
  }
}
