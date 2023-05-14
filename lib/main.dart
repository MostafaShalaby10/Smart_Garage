import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled/admin/homePage.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/dio/dio.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/pages/getstarted.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';
import 'package:untitled/user/homepage.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange,
      statusBarIconBrightness: Brightness.light
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await dio.init();
  await Firebase.initializeApp();
  await sharedprefs.init();
  bool isgetstarted = sharedprefs.getdata(key: "getstarted");
  bool islogin = sharedprefs.getdata(key: "login");
  String role = sharedprefs.getdata(key: "role");
  if (isgetstarted == null) {
    runApp(MyApp(
      start: getstarted(),
    ));
  } else {
    if (islogin == null) {
      runApp(MyApp(
        start: login(),
      ));
    } else {
      if(role=="user") {
        runApp(MyApp(
          start: homepage(),
        ));
      }
      else if(role=="admin")
        {
          runApp(MyApp(
            start: AdminHomePage(),
          ));
        }

    }
  }
}

class MyApp extends StatelessWidget {
  // final bool isgetstarted ;
  // final bool islogin ;
  final Widget start;

  const MyApp({required this.start});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit, states>(
        builder: (context, state) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            ////////////////////////////////////////////////////////////////////////////////
            home: start ,
            localizationsDelegates: [
              AppLocale.delegate ,
              GlobalMaterialLocalizations.delegate ,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [
              Locale("en" , "") ,
              Locale("ar" , "")
            ],
            localeResolutionCallback: (current , support)
            {
              if(current != null)
                {
                  for(Locale locale in support)
                    {
                        if(locale.languageCode==current.languageCode)
                          {
                             return current;
                          }
                    }
                }
              return support.first;
            },
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
