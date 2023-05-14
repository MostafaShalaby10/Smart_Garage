import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';


import '../shared.dart';
import '../shared.dart';
import '../shared.dart';

class floor1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit()..readDataPublic(),
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
                  ConditionalBuilder(
                    condition: state is! LoadingGetPublicDataState,
                    builder: (context) => SingleChildScrollView(
                      child: Column(
                        children: [
                          topContainer(context, showmenu: false, raduis: 0 ),
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
                                    text: "P1", fill: publicMap!["P1"]),
                                Spacer(),
                                publicSlot(context,
                                    text: "P2", fill: publicMap!["P2"]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                publicSlot(context,
                                    text: "P3", fill: publicMap!["P3"]),
                                Spacer(),
                                publicSlot(context,
                                    text: "P4", fill: publicMap!["P4"]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                publicSlot(context,
                                    text: "P5", fill: publicMap!["P5"]),
                                Spacer(),
                                publicSlot(context,
                                    text: "P6", fill: publicMap!["P6"]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ],
              )),
            );
          },
          listener: (context, state) {}),
    );
  }
}
