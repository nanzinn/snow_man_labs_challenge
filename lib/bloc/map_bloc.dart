import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:snowmanlabs_challenge/common_widgets/rounded_modal_widget.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:snowmanlabs_challenge/ui/map/widgets/place_info_widget.dart';
import 'package:snowmanlabs_challenge/utils/conts.dart';

MapBLoC getMapBLoC(BuildContext context) {
  return Provider.of<MapBLoC>(context);
}

class MapBLoC {
  String lastSearch;
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_API);

  MapBLoC() {
    changedKeyboardVisibility(false);
  }

  final locationData = new BehaviorSubject<LatLng>();

  LatLng currentLocationData() => locationData.value;

  final searchData = new BehaviorSubject<List<PlacesSearchResult>>();

  List<PlacesSearchResult> currentSearchData() => searchData.value;

  final keyboardChanged = new BehaviorSubject<bool>();

  bool currentKeyboardChanged() => keyboardChanged.value;

  final markersData = new BehaviorSubject<Set<Marker>>();

  Set<Marker> currentMarkersData() => markersData.value;

  void whenLocationIsFounded(LatLng location) => locationData.sink.add(location);

  void onSearchTextChanged({String text}) async {
    lastSearch = text;
    final result = await places.searchByText(lastSearch,
        location: Location(currentLocationData().latitude, currentLocationData().longitude));
    searchData.sink.add(result.results);
  }

  void clearSearchResults() async {
    searchData.sink.add(null);
  }

  void changedKeyboardVisibility(bool isVisible) {
    if (isVisible) onSearchTextChanged(text: lastSearch);
    keyboardChanged.sink.add(isVisible);
  }



  void getNearbyPlaces(BuildContext context, LatLng center) async {
    List<PlacesSearchResult> resultList = List();
    final location = Location(center.latitude, center.longitude);
    final resultMuseum = await getMapBLoC(context).places.searchByText(
          "Museum",
          location: location,
          radius: 5,
        );
    if (resultMuseum.status == "OK") resultList.addAll(resultMuseum.results);
    final resultPark = await getMapBLoC(context).places.searchByText(
          "Park",
          location: location,
          radius: 5,
        );
    if (resultPark.status == "OK") resultList.addAll(resultPark.results);
    final resultTheater = await getMapBLoC(context).places.searchByText(
          "Theater",
          location: location,
          radius: 5,
        );
    if (resultTheater.status == "OK") resultList.addAll(resultTheater.results);
    final resultMonument = await getMapBLoC(context).places.searchByText(
          "Monument",
          location: location,
          radius: 5,
        );
    if (resultMonument.status == "OK") resultList.addAll(resultMonument.results);
    resultList.forEach((f) {
      _add(context, f);
    });
  }

  void _add(BuildContext context, PlacesSearchResult result) {
    final String markerIdVal = result.name;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(result.geometry.location.lat, result.geometry.location.lng),
      infoWindow: InfoWindow(title: markerIdVal, snippet: result.formattedAddress),
      onTap: () {
        onMarkerTapped(context, result);
      },
      onDragEnd: (LatLng position) {},
    );
    Set<Marker> savedMarker = currentMarkersData() ?? Set<Marker>();
    savedMarker.add(marker);
    markersData.sink.add(savedMarker);
  }

  void onMarkerTapped(BuildContext context, PlacesSearchResult result) {
    showRoundedModalBottomSheet(
        context: context,
        autoResize: true,
        margin: EdgeInsets.symmetric(horizontal: w(20)),
        radius: w(10.0),
        // This is the default
        color: Colors.white,
        // Also default
        builder: (context) => Provider(child: PlaceInfoWidget(result)));
  }

  void dispose() {
    locationData?.close();
    searchData?.close();
    places?.dispose();
    keyboardChanged?.close();
    markersData?.close();
  }
}
