import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';


Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

ThemeData dartkTheme = ThemeData(
      iconTheme: IconThemeData(
        color: Colors.grey,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: defaultBackGroundColor,
      primarySwatch:MaterialColor(0xFF9C0B0B, color),

      appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        titleSpacing: 20.0,
        backgroundColor: defaultBackGroundColor,
        elevation: 1.0,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  defaultBackGroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
         // fontFamily: 'Horizon',
        ),
        actionsIconTheme: IconThemeData(
            color: whiteColor
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: greyColor,
        elevation: 20.0,
        backgroundColor: HexColor('1e1c1c'),
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              overflow: TextOverflow.ellipsis ,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: whiteColor
          )
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: defaultColor,
        foregroundColor:  whiteColor,
      ),
      //fontFamily: FontApp
    );

ThemeData ligthTheme = ThemeData(
        iconTheme: IconThemeData(
          color: Colors.black38,
        ),
        brightness: Brightness.light,
        primarySwatch: MaterialColor(0xFFCE2727, color),
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: AppBarTheme(

          backwardsCompatibility: false,
          titleSpacing: 20.0,
          backgroundColor: whiteColor,
          elevation: 1.0,

          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: whiteColor10,
              statusBarIconBrightness: Brightness.dark
          ),
          titleTextStyle: TextStyle(
            color:blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          //  fontFamily: FontApp,
          ),
          actionsIconTheme: IconThemeData(
              color: blackColor
          ),
          iconTheme: IconThemeData(
              color: blackColor
          ),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: defaultColor,
            unselectedItemColor: greyColor,
            elevation: 20.0
        ),

        textTheme: TextTheme(
            bodyText1: TextStyle(
                overflow: TextOverflow.ellipsis ,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: blackColor
            )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
            foregroundColor: whiteColor,
        ),
       // fontFamily: FontApp
      );





