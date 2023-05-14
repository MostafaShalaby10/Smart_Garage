import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/models/user_model.dart';


class UserDetails extends StatelessWidget {
  UserModel userModel;

  UserDetails({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          cubit()..getUserData(userId: userModel.id),
      child: BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ConditionalBuilder(

                    builder: (context) => SingleChildScrollView(
                      physics: BouncingScrollPhysics(),

                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: 10,),

                            Row(
                              children: [
                                Icon(Icons.person) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].name}")),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.email_outlined) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].email}")),
                              ],
                            ),
                            SizedBox(height: 10,),


                            Row(
                              children: [
                                Icon(Icons.timer) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].period}")),

                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].date}")),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.numbers) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].location}")),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.star_rate) ,
                                SizedBox(width: 15,),
                                Expanded(child: Text("${cubit.get(context).userData[index].rate}")),

                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                        separatorBuilder:  (context, index) => Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                        itemCount: cubit.get(context).userData.length,
                      ),
                    ),
                    condition: cubit.get(context).userData.length > 0,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
