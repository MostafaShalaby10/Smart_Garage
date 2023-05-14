import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/shared.dart';


class floor2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>cubit() ..readDataPrivate(),
      child: BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("lib/images/3.jpg"),
                              fit: BoxFit.cover,
                              repeat: ImageRepeat.repeatY))),
                  ConditionalBuilder(condition: state is! LoadingGetPublicDataState, builder: (context)=>SingleChildScrollView(
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
                                "Empty Spaces : $privateCounter /6 ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),

                        SizedBox(
                          height: 30,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              privateSlot(context, text: "P1", fill: privateMap!["P1"]),
                              Spacer(),
                              privateSlot(context, text: "P2", fill: privateMap!["P2"]),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              privateSlot(context, text: "P3", fill: privateMap!["P3"]),
                              Spacer(),
                              privateSlot(context, text: "P4", fill: false),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              privateSlot(
                                context,
                                text: "P5",
                                fill: false,
                              ),
                              Spacer(),
                              privateSlot(context, text: "P6", fill: false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) , fallback: (context)=>Center(child: CircularProgressIndicator()),),
                ]),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
