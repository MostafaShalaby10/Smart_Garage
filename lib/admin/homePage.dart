import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/admin/floor1.dart';
import 'package:untitled/admin/floor2.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/languages/locale.dart';


class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => cubit() ..stopWatch(),
        child: BlocConsumer<cubit , states>(
            builder: (context , state)
            {
              return Scaffold(
                backgroundColor: Colors.grey[200],
                body: SafeArea (
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        topContainer (context , showmenu: true , user: false) ,
                        SizedBox(height: 80,) ,
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AadminFloor1())) ;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20) ,
                                    boxShadow: [BoxShadow(blurRadius: 5 , offset: Offset(0,5)) ,
                                      BoxShadow(color: Colors.white , offset: Offset(-5,0)) ,]
                                ),
                                width: MediaQuery.of(context).size.width/1.5,
                                height: MediaQuery.of(context).size.height/4.5,
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
                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AadminFloor2()));},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20) ,
                                    boxShadow: [BoxShadow(blurRadius: 5 , offset: Offset(0,5)) ,
                                      BoxShadow(color: Colors.white , offset: Offset(-5,0)) ,]
                                ),
                                width: MediaQuery.of(context).size.width/1.5,
                                height: MediaQuery.of(context).size.height/4.5,
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
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey,
                                    ) ,
                                    SizedBox(height: 15,),
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
