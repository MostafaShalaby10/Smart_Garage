import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/admin/chatlist.dart';
import 'package:untitled/admin/userslist.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';
import 'package:untitled/user/book_screen.dart';
import 'package:untitled/user/chat.dart';
import 'package:untitled/user/settings.dart';

Widget topContainer(context, {required bool showmenu, bool user = true , double raduis = 70}) {
  List<PopupMenuEntry> list = [
    if (user == true)
      PopupMenuItem(
        value: 0,
        child: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            Text("${getLang(context, "settings")}")
          ],
        ),
      ),
    if(user==true)
      PopupMenuItem(
        value: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.help),
            SizedBox(
              width: 10,
            ),
            Text("${getLang(context, "support")}")
          ],
        ),
      ),
    if(user==false)
      PopupMenuItem(
        value: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text("${getLang(context, "users")}")
          ],
        ),
      ),
    if(user==false)
      PopupMenuItem(
        value: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.chat),
            SizedBox(
              width: 10,
            ),
            Text("${getLang(context, "messages")}")
          ],
        ),
      ),

    PopupMenuItem(
      value: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.logout),
          SizedBox(
            width: 10,
          ),
          Text("${getLang(context, "logout")}")
        ],
      ),
    ),


  ];
  return Stack(alignment: Alignment.topLeft, children: [
    Container(
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(raduis),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
          BoxShadow(color: Colors.deepOrange, offset: Offset(-5, 0)),
        ],
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height/3.5,
      // height: 300,
      child: Image(
        image: AssetImage("lib/images/1.PNG")
      ),
    ),
    if (showmenu)
      PopupMenuButton(
        color: Colors.grey[200],
        itemBuilder: (context) => list,
        icon: Icon(Icons.more_vert_rounded, color: Colors.white),
        onSelected: (value) {
          if (value == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => login()),
                (route) => false);
            sharedprefs.removedata(key: "login");
            sharedprefs.removedata(key: "UID");
            sharedprefs.removedata(key: "role");
          } else if (value == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => settings()));
          } else if (value == 2) {
            if(user==true)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportChat()));
              }else
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatList()));

                }
          }else if(value==3)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList()));

            }
        },
      ),
  ]);
}

Widget publicSlot(context,
        {required String text, required bool fill}) =>
    Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 12,
          height: MediaQuery.of(context).size.height / 22,
          decoration: BoxDecoration(
            color: fill ? Colors.green : Colors.red,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: HexColor('#323232'),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
          child: Center(
            child: Text(
              "$text",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),

      ],
    );

Widget privateSlot(context,
        {required String text, required bool fill}) =>
    Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 12,
          height: MediaQuery.of(context).size.height / 22,
          decoration: BoxDecoration(
            color: fill ? Colors.green : Colors.red,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: HexColor('#323232'),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
          child: Center(
            child: Text(
              "$text",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        if (fill)
          Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 16,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(blurRadius: 5.0, offset: Offset(0, 1)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                ]),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookScreen(
                              location: text,
                            )));
              },
              child: Text(
                '${getLang(context, "book")}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
      ],
    );

Widget button({
  required context,
  required String text,
  required Function() function,
  double fontSize = 25,
}) =>
    Container(
      width: MediaQuery.of(context).size.width /1.5,
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(blurRadius: 5.0, offset: Offset(0, 1)),
            BoxShadow(color: Colors.deepOrange, offset: Offset(-5, 0)),
          ]),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "$text",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
      ),
    );

Widget editText(context,
        {required bool ispassword,
        required TextInputType type,
        required String text,
        required IconData prefixIcon,
        IconData? suffixIcon,
        Function()? function,
        required TextEditingController controller}) =>
    Container(
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(25) ,
          boxShadow: [
            BoxShadow(blurRadius: 5.0, offset: Offset(0, 5) , color: Colors.grey ),
            BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
          ]),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "${text + getLang(context, 'cantempty')}";
          }
          return null;
        },
        keyboardType: type,
        obscureText: ispassword,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(
            prefixIcon,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: function, icon: Icon(suffixIcon))
              : null,
        ),
      ),
    );

Widget customSlot(context,
        {required String text, required bool book, required bool fill}) =>
    Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 12,
          height: MediaQuery.of(context).size.height / 22,
          decoration: BoxDecoration(
            color: fill ? Colors.green : Colors.red,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: HexColor('#323232'),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(blurRadius: 5.0, offset: Offset(0, 2)),
              BoxShadow(color: Colors.white, offset: Offset(-1, 0)),
            ],
          ),
          child: Center(
            child: Text(
              "$text",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        if (book && fill)
          Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 16,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(blurRadius: 5.0, offset: Offset(0, 1)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                ]),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookScreen(
                              location: text,
                            )));
              },
              child: Text(
                '${getLang(context, "book")}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
      ],
    );
