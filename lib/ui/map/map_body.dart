import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snowmanlabs_challenge/bloc/map_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:flutter/services.dart';
import 'package:snowmanlabs_challenge/common_widgets/screen_size_widget.dart';
import 'package:snowmanlabs_challenge/ui/map/widgets/search_result_widget.dart';
import 'package:snowmanlabs_challenge/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class MapBody extends StatefulWidget {
  @override
  _MapBodyState createState() => _MapBodyState();
}

class _MapBodyState extends State<MapBody> {
  static final LatLng center = const LatLng(-33.86711, 151.1947171);
  GoogleMapController controller;
  MarkerId selectedMarker;
  GoogleMapController _mapController;
  PlacesDetailsResponse place;
  List<PlacesSearchResult> places = [];
  List<TabData> tabItems = List.of([
    TabData(
        iconData: Icons.star,
        title: "",
        onclick: () {
          //final FancyBottomNavigationState fState =
          // bottomNavigationKey.currentState;
          // fState.setPage(2);
        }),
    TabData(
        iconData: Icons.location_on,
        title: "",
        onclick: () {
          //final FancyBottomNavigationState fState =
          // bottomNavigationKey.currentState;
          // fState.setPage(2);
        }),
    TabData(
        iconData: Icons.person,
        title: "",
        onclick: () {
          //final FancyBottomNavigationState fState =
          // bottomNavigationKey.currentState;
          // fState.setPage(2);
        }),
  ]);
  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController()..addListener(_searchControllerTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchControllerTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      StreamBuilder<Set<Marker>>(
          stream: getMapBLoC(context).markersData,
          builder: (context, snapshot) {
            return GoogleMap(
              onMapCreated: _onMapCreated,
              buildingsEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: false,
              rotateGesturesEnabled: true,
              padding: EdgeInsets.zero,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              markers: snapshot.data,
              onTap: (_) {
                getMapBLoC(context).clearSearchResults();
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 14.4746,
              ),
            );
          }),
      Positioned(
        top: w(15),
        right: w(15),
        left: w(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: new Offset(5.0, 10.0),
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(10)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: w(20),
                      color: SnowColors.lightGrey,
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: w(15)),
                            hintText: "Search..."),
                      ),
                    ),
                    Container(
                      width: w(.7),
                      color: Colors.grey,
                      height: w(30),
                    ),
                    SizedBox(
                      width: w(10),
                    ),
                    Icon(
                      Icons.add,
                      color: SnowColors.grey2,
                      size: w(23),
                    )
                  ],
                ),
              ),
              StreamBuilder<List<PlacesSearchResult>>(
                  stream: getMapBLoC(context).searchData,
                  builder: (context, snapshot) {
                    return !snapshot.hasData || snapshot.data.length == 0
                        ? Container()
                        : Container(
                            constraints: BoxConstraints(maxHeight: w(300), minHeight: w(55)),
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  height: w(.7),
                                  color: SnowColors.lightGrey,
                                ),
                                ...snapshot.data
                                    .map((data) => Provider(
                                        create: (_) => getMapBLoC(context),
                                        child: SearchResultWidget(
                                            searchResult: data,
                                            onTap: () =>
                                                getMapBLoC(context).onMarkerTapped(context, data))))
                                    .toList()
                              ],
                            ),
                          );
                  })
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: w(50),
          child: FancyBottomNavigation(
            tabs: tabItems,
            onTabChangedListener: (int selectedPos) {},
            initialSelection: 0,
          ),
        ),
      )
    ]));
  }


  void refresh() async {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(await _getYourCameraPosition()
        ));
    getMapBLoC(context).getNearbyPlaces(context, center);
  }

  Future<CameraPosition> _getYourCameraPosition() async {
    LatLng center = await _getCurrentLocation();
    return CameraPosition(target: center == null ? LatLng(0, 0) : center, zoom: 15.0);
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    refresh();
  }

  Future<LatLng> _getCurrentLocation() async {
    LocationManager.Location location = new LocationManager.Location();
    try {
      LocationManager.LocationData currentLocation = await location.getLocation();
      getMapBLoC(context)
          .locationData
          .sink
          .add(LatLng(currentLocation.latitude, currentLocation.longitude));
      return LatLng(currentLocation.latitude, currentLocation.longitude);
    } on PlatformException catch (e) {}
    return null;
  }

  void _searchControllerTextChanged() {
    if (_searchController.text != getMapBLoC(context).lastSearch) {
      getMapBLoC(context).onSearchTextChanged(text: _searchController.text);
    }
  }
}
