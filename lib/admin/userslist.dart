import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/admin/userdetails.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/models/user_model.dart';


class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit() ..getUsers(),
      child: BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Text("Users" ,style: TextStyle(color: Colors.black),),
              ),

              body: Container(
                color: Colors.white,
                child: ConditionalBuilder(
                  builder: (context)=>SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildChatItem(cubit.get(context).users[index], context),
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black,
                      ),
                      itemCount: cubit.get(context).users.length,
                    ),
                  ),
                  condition: state is! LoadingGetUsersState,
                  fallback: (context)=>Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
          listener: (context, state) {}),
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
    onTap: () {
      print(model.id);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>UserDetails(
            userModel: model,
          ),)
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(
            Icons.person_outline ,
            size: 30,
          ),
          SizedBox(width: 15,),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );

}
