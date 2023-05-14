import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'coffee_model.dart';
import 'map_states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(MapInitialState());

  static MapCubit get(context) => BlocProvider.of(context);

  List<Marker> allMarkers = [];
  late PageController pageController;
  late int prevPage = 0;
  late GoogleMapController _controller;

  void mapCreated(controller) {
    _controller = controller;
  }

  void InitialMarker() {
    coffeeShops.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.shopName, snippet: element.address),
          position: element.locationCoords));
    });

    pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (pageController.page!.toInt() != prevPage) {
      prevPage = pageController.page!.toInt();
      moveCamera();
    }
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[pageController.page!.toInt()].locationCoords,
        zoom: 20.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  coffeeShopList(index , context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.3) + 0.16).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: MediaQuery.of(context).size.width/6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[200]),
                        child:
                        Center(
                          child: Text(
                            coffeeShops[index].shopName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                        ))))
          ])),
    );
  }

  void addCurrentLocation(LatLng locationCoords) {
    allMarkers.add(Marker(
        markerId: MarkerId('your location'),
        draggable: false,
        infoWindow: InfoWindow(
          title: 'your location',
        ),
        position: locationCoords));

    int x = 0;
    coffeeShops.forEach((element) {
      if (locationCoords.latitude - element.locationCoords.latitude < .0007 &&
          locationCoords.longitude - element.locationCoords.longitude < .0007) {
        print('dooooooooooooone ');
        x = 1;
      }
    });

    if (x == 0)
      emit(MapErrorNearbyWorkState(onError.toString()));
    else
      emit(MapSuccessNearbyWorkState());

    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: locationCoords, zoom: 20.0, bearing: 45.0, tilt: 45.0)));
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    emit(MapLoadingState());

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(MapErrorOpenGPSState(onError.toString()));
      return Future.error('Location services are disabled.');
    } else {
      emit(MapSuccessOpenGPSState());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(MapErrorState(onError.toString()));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position current_location;
    current_location = await Geolocator.getCurrentPosition();
    emit(MapSuccessState());
    print(current_location);
    addCurrentLocation(
        LatLng(current_location.latitude, current_location.longitude));
    return current_location;
  }
}
