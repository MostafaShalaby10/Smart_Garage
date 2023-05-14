import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/admin/homePage.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';
import 'package:untitled/user/forgetpassword.dart';
import 'package:untitled/user/homepage.dart';
import 'package:untitled/user/signup.dart';



class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  var emailtext = TextEditingController() ;

  var passwordtxt = TextEditingController() ;
bool ispass = true ;
  var formkey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , states>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    topContainer(context , showmenu: false),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            editText(context ,
                              controller:emailtext ,
                              ispassword: false,
                              type: TextInputType.emailAddress,
                              text: "${getLang(context, "email")}",
                              prefixIcon: Icons.email,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            editText(context ,
                                controller: passwordtxt,
                                ispassword: ispass,
                                type: TextInputType.visiblePassword,
                                text: "${getLang(context, "pass")}",
                                prefixIcon: Icons.lock,
                                suffixIcon: ispass ? Icons.visibility : Icons.visibility_off ,
                                function: (){
                                  setState(() {
                                    ispass = !ispass ;
                                  }); ;
                                }
                            ) ,
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetpassword())) ;
                              },
                              child: Text(
                                "${getLang(context, "forgetpass")}" ,
                                style: TextStyle(
                                    color: Colors.deepOrange ,
                                    fontSize: 16 ,
                                    fontWeight: FontWeight.bold
                                ),) ,
                            ) ,
                            SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition: state is! loginloadingstate,
                              builder:(context)=>button(context: context, text: "${getLang(context, "login")}",
                                  function: (){
                                    sharedprefs.savedata(key: "login", value: true) ;

                                    if(formkey.currentState!.validate())
                                    {

                                      cubit.get(context).login(email: emailtext.text, password: passwordtxt.text);
                                    }
                                  } , fontSize: 25),
                              fallback: (context)=>Center(child: CircularProgressIndicator()),
                            ) ,
                            SizedBox(height: 20,) ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${getLang(context, "donthaveaccount")}",
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup())) ;
                                    },
                                    child: Text(
                                      "${getLang(context, "signup")}",
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
          ) ;
        },
        listener: (context, state) {
          if (state is loginsuccessstate)
          {
            if(emailtext.text=="graduationproject811@gmail.com" && passwordtxt.text=="mostafa2001")
            {
              sharedprefs.savedata(key: "role", value: "admin");
              Fluttertoast.showToast(
                  msg: "${getLang(context, "loginasadmin")}",
                  backgroundColor: Colors.green,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminHomePage()), (route) => false) ;
            }else
              {
                sharedprefs.savedata(key: "role", value: "user");

                Fluttertoast.showToast(
                    msg: "${getLang(context, "loginsuccessfully")}",
                    backgroundColor: Colors.green,
                    toastLength: Toast.LENGTH_SHORT,
                    textColor: Colors.white,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ),
                        (route) => false);
              }

          }else if(state is loginerrorstate)
            {
              Fluttertoast.showToast(
                  msg: "${getLang(context, "loginfailed")}",
                  backgroundColor: Colors.red,
                  toastLength: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
            }

        },);
  }
}
