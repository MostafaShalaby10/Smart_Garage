import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/user/REF_code_screen.dart';
import 'package:untitled/user/visa_screen.dart';



class toggle extends StatelessWidget {
  const toggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , states>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          cubit.get(context).getRefCode();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ref_code()));
                        },
                        child: Container(
                          child: Image(
                            height: 300,
                            image: AssetImage("lib/images/6.jpg"),
                          ),
                        ),
                      ),
                    ) ,
                    Expanded(
                      child: InkWell(
                        onTap: ()
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisaScreen()));
                        },
                        child: Container(
                          child: Image(
                            height: 300,
                            image: AssetImage("lib/images/7.jpg"),
                          ),
                        ),
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {

        });
  }
}
