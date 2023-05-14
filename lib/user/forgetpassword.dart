import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/pages/login.dart';

import '../components/components.dart';



class forgetpassword extends StatefulWidget {
  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  var emailtext = TextEditingController();

  var newpasswordtxt = TextEditingController();

  var confpasswordtxt = TextEditingController();

  bool ispass = true;

  bool isconfpass = true;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, states>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  topContainer(context, showmenu: false),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          editText(
                            context,
                            controller: emailtext,
                            ispassword: false,
                            type: TextInputType.emailAddress,
                            text: "${getLang(context, "email")}",
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 60,
                          ),

                          button(
                            context: context,
                            text: "${getLang(context, "resetpass")}",
                            function: () {
                              if (formkey.currentState!.validate()) {


                                FirebaseAuth.instance.sendPasswordResetEmail(email: emailtext.text).then((value)
                                {
                                  Fluttertoast.showToast(
                                      msg:
                                      "${getLang(context, "checkemail")}",
                                      backgroundColor: Colors.green,
                                      toastLength: Toast.LENGTH_SHORT,
                                      textColor: Colors.white,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => login(),
                                      ),
                                          (route) => false);
                                }).catchError((error){
                                  print(error.toString());
                                });

                              }
                            },
                            fontSize: 25,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${getLang(context, "rememberpass")}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "${getLang(context, "login")}",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
