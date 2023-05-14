import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/constants.dart';



import '../components/components.dart';

class ref_code extends StatelessWidget {
  const ref_code({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , states>(
      builder: (context , state)
        {
         return Scaffold(
            body: SafeArea(
              child: Center(
                child: ConditionalBuilder(condition: state is! getrefcodeloadingstate,
                  builder: (context)=>Column(
                    children: [
                      topContainer(context, showmenu: false) ,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                                  "You should go to park to pay" ,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold ,
                                      fontSize: 25
                                  ),
                                )
                            ),
                            SizedBox(height: 20,),
                            Center(
                                child: Text(
                                  "This is reference code" ,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold ,
                                      fontSize: 17 ,

                                  ),
                                )
                            ),
                            SizedBox(height: 20,),
                            Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20) ,
                                      boxShadow: [BoxShadow(blurRadius: 5 , offset: Offset(0,5)) ,
                                        BoxShadow(color: Colors.white , offset: Offset(-5,0)) ,]
                                  ),
                                  width: 300,
                                  height: 70,
                                  child: Center(
                                    child: Text(
                                      "${constants.refCode}" ,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold ,
                                          fontSize: 30
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      )


                    ],
                  ) ,
                  fallback: (context)=>Center(child: CircularProgressIndicator()),),
              ),
          ) );
        },

        listener: (context , state){},
    );
  }
}
