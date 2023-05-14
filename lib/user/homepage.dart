import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/languages/locale.dart';
import 'package:untitled/module/map/maps_screen.dart';
import 'package:untitled/user/floor1.dart';
import 'package:untitled/user/floor2.dart';



class homepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => cubit()..getUser(),
    child: BlocConsumer<cubit , states>(
        builder: (context , state)
        {
         return Scaffold(
            backgroundColor: Colors.grey[200],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: Icon(
                Icons.location_on_outlined,
                size:30,

              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapsScreen()));

              },
            ),
            body: SafeArea (
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    topContainer (context , showmenu: true) ,
                    SizedBox(height: 80,) ,
                    Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> floor1())) ;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20) ,
                                boxShadow: [BoxShadow(blurRadius: 5 , offset: Offset(0,5)) ,
                                  BoxShadow(color: Colors.white , offset: Offset(-5,0)) ,]
                            ),
                            width: MediaQuery.of(context).size.width/1.5,
                            height: MediaQuery.of(context).size.height/5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${getLang(context, "firstfloor")}" ,
                                  style: TextStyle(
                                      color: Colors.black ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: 25
                                  ),
                                ) ,
                                SizedBox(height: 10,),
                                Text(
                                  "${getLang(context, "public")}" ,
                                  style: TextStyle(
                                      color: Colors.grey[500] ,
                                      fontSize: 18
                                  ),
                                ) ,
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        ) ,
                        SizedBox(height: 30,) ,
                        InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> floor2()));},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20) ,
                                boxShadow: [BoxShadow(blurRadius: 5 , offset: Offset(0,5)) ,
                                  BoxShadow(color: Colors.white , offset: Offset(-5,0)) ,]
                            ),
                            width: MediaQuery.of(context).size.width/1.5,
                            height: MediaQuery.of(context).size.height/5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${getLang(context, "secondfloor")}" ,
                                  style: TextStyle(
                                      color: Colors.black ,
                                      fontWeight: FontWeight.bold ,
                                      fontSize: 25
                                  ),
                                ) ,
                                SizedBox(height: 10,),
                                Text(
                                  "${getLang(context, "private")}" ,
                                  style: TextStyle(
                                      color: Colors.grey[500] ,
                                      fontSize: 18
                                  ),
                                ) ,
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                        ) ,

                      ],
                    ) ,

                  ],
                ),
              ),
            ),
          );
        },
        listener:(context , state){} )
    );
  }
}
