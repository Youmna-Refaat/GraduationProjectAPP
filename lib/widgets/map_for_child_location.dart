import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_application/utils/refactored_location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapForChildLocation extends StatefulWidget {
  const MapForChildLocation({super.key});

  @override
  State<MapForChildLocation> createState() => _MapForChildLocationState();
}

class _MapForChildLocationState extends State<MapForChildLocation> {
  late CameraPosition initialCameraPosition;
  late RefactoredLocationService refactoredLocationService;
  late GoogleMapController googleMapController;
  bool isFirstCall = true;
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      zoom: 12,
      target: LatLng(26.90097230497843, 30.096924944177502),
    );
    refactoredLocationService = RefactoredLocationService();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      circles: circles,
      markers: markers,
      onMapCreated: (controller) {
        googleMapController = controller;
        fetchFirestoreLocationAndUpdate();
        initMapStyle();
      },
      initialCameraPosition: initialCameraPosition,
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night.json');
    googleMapController.setMapStyle(nightMapStyle);
  }

  void fetchFirestoreLocationAndUpdate() async {
    try {
      User? supervisor = FirebaseAuth.instance.currentUser;
      if (supervisor != null) {
        DocumentSnapshot locationSnapshot = await FirebaseFirestore.instance
            .collection('supervisors')
            .doc(supervisor.uid)
            .collection('locations')
            .doc('initialLocation')
            //.doc('currentLocation')
            .get();

        if (locationSnapshot.exists) {
          double latitude = locationSnapshot['latitude'];
          double longitude = locationSnapshot['longitude'];

          CameraPosition myCurrentCameraPosition = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 16,
          );

          googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(myCurrentCameraPosition));
          myLocationMarker(latitude, longitude);
        } else {
          // Handle the case where location data doesn't exist
        }
      }
    } catch (e) {
      // Handle errors
      print("Error fetching location data: $e");
    }
  }

  void myLocationMarker(double latitude, double longitude) async {
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/marker.png');
    var myLocationMarker = Marker(
      icon: customMarkerIcon,
      markerId: const MarkerId('current location'),
      position: LatLng(latitude, longitude),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }
}
