import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/shared.dart';
import 'package:untitled/user/update.dart';


class settings extends StatelessWidget {
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, states>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(children: [
                    topContainer(context, showmenu: true),
                    SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                      condition: state is! getuserloadingstate,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => update()));
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${getLang(context, "edit")}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  radius: 25,
                                  child: Icon(
                                    Icons.email_outlined,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${email}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                                // Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  radius: 25,
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                                // Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  radius: 25,
                                  child: Icon(
                                    Icons.phone_outlined,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "${phone}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                                // Spacer(),
                                // IconButton(onPressed: (){},
                                //     icon: Icon(
                                //       Icons.edit
                                //     ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
