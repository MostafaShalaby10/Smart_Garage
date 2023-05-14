import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/shared.dart';
import 'package:untitled/user/payment_screen.dart';



class BookScreen extends StatelessWidget {
  final String location;
   BookScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: topContainer(context, showmenu: false),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 60),
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5.0, offset: Offset(0, 5)),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-5, 0)),
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Name ",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '$name',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${getLang(context, "location")}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '$location',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${getLang(context, "time")}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cubit.get(context).minus();
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "${cubit.get(context).counter}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cubit.get(context).plus();
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),


                                      Container(
                                        height: 3,
                                        color: Colors.grey[500],
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${getLang(context, "total")}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${cubit.get(context).counter * 5}\$',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${getLang(context, 'foronehour')} ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '5\$ ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ))
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: button(context: context, text: "BOOK", function: (){
                          cubit.get(context).getAuthToken();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>payment(location: location)));
                        }),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(blurRadius: 5.0, offset: Offset(0, 1)),
                              BoxShadow(
                                  color: Colors.deepOrange,
                                  offset: Offset(-5, 0)),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
