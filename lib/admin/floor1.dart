import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/shared.dart';


import '../components/components.dart';

class AadminFloor1 extends StatelessWidget {
  final stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit() ..stopWatch(),
      child: BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: SafeArea(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("lib/images/3.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        topContainer(context, showmenu: false , raduis: 0),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(90),
                              ),

                            ),

                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10
                              ),
                              child: Text(
                                "Empty Spaces : $publicCounter /6 ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              publicSlot(context,
                                  text:
        cubit.get(context).timerFlagP1==true ?  "${cubit.get(context).durationP1.inHours.remainder(60)} : ${cubit.get(context).durationP1.inMinutes.remainder(60)} : ${cubit.get(context).durationP1.inSeconds.remainder(60)}":"IDLE",

                                  fill: false),
                              Spacer(),
                              publicSlot(context,
                                  text: "P2",  fill: true),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              publicSlot(context,
                                  text: "P3",  fill: false),
                              Spacer(),
                              publicSlot(context,
                                  text: "P4",  fill: false),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              publicSlot(context,
                                  text: "P5",  fill: true),
                              Spacer(),
                              publicSlot(context,
                                  text: "P6",  fill: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            );
          },
          listener: (context, state) {}),
    );
  }
}
