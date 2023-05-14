import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'coffee_model.dart';
import 'map_cubit.dart';
import 'map_states.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MapCubit()..InitialMarker(),
        child: BlocConsumer<MapCubit, MapStates>(listener: (context, state) {
          Timer(Duration(seconds: 5), () {
            if (state is MapSuccessNearbyWorkState) {
              Fluttertoast.showToast(
                  msg: "Attendance has been registered successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            if (state is MapErrorNearbyWorkState) {
              Fluttertoast.showToast(
                  msg: "Attendance has not been registered successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          });

          if (state is MapErrorOpenGPSState) {
            Fluttertoast.showToast(
                msg: "GPS NOT OPEN",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          if (state is MapErrorState) {
            Fluttertoast.showToast(
                msg: "Access Deny",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }, builder: (context, state) {
          var mapCubit = MapCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.deepOrange,
                title: Text('Maps'),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onLongPress: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(1, 0, 0, 0),
                        items: <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Check your location",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ).then((value) => {print(value.toString())});
                    },
                    child: IconButton(
                      onPressed: () {
                        print('Attendance');
                        mapCubit.determinePosition();
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(31.36221141403527, 27.220783897025207),
                          zoom: 12.0),
                      markers: Set.from(mapCubit.allMarkers),
                      onMapCreated: mapCubit.mapCreated,
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: mapCubit.pageController,
                        itemCount: coffeeShops.length,
                        itemBuilder: (BuildContext context, int index) {
                          return mapCubit.coffeeShopList(index, context);
                        },
                      ),
                    ),
                  ),
                ],
              ));
        }));
  }
}
