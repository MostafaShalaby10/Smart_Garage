import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';

import '../models/user_model.dart';


class Chats extends StatelessWidget {
  var controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UserModel userModel;
  Chats({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        cubit.get(context).getMessages(receiverId: userModel.id);
        return BlocConsumer<cubit, states>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                // automaticallyImplyLeading: false,
                // foregroundColor: Colors.black,
                elevation: 10.0,
                backgroundColor: Colors.deepOrange,
                title:   Container(
                  // width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${userModel.name}',

                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
                centerTitle: true,
              ),

              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ConditionalBuilder(
                          condition: cubit.get(context).messages.length > 0,
                          builder: (context) => Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  // physics: NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (sharedprefs.getdata(key: "UID") !=
                                        cubit
                                            .get(context)
                                            .messages[index]
                                            .senderId)
                                      return Align(
                                        alignment:
                                        AlignmentDirectional.centerStart,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                              BorderRadiusDirectional.only(
                                                bottomEnd: Radius.circular(
                                                  10.0,
                                                ),
                                                topStart: Radius.circular(
                                                  10.0,
                                                ),
                                                topEnd: Radius.circular(
                                                  10.0,
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 5.0,
                                              horizontal: 10.0,
                                            ),
                                            child: Wrap(children: [
                                              Text(
                                                "${cubit.get(context).messages[index].text}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      );
                                    return Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade400,
                                            borderRadius:
                                            BorderRadiusDirectional.only(
                                              bottomEnd: Radius.circular(
                                                10.0,
                                              ),
                                              topStart: Radius.circular(
                                                10.0,
                                              ),
                                              topEnd: Radius.circular(
                                                10.0,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 5.0,
                                            horizontal: 10.0,
                                          ),
                                          child: Wrap(children: [
                                            Text(
                                              "${cubit.get(context).messages[index].text}",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, state) => SizedBox(
                                    height: 5,
                                  ),
                                  itemCount: cubit.get(context).messages.length,
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                controller: controller,
                                obscureText: false,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Message can't be empty";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  // enabledBorder: ,
                                  label: Text("Message"),
                                ),

                              ) ,),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height / 13,
                              child: MaterialButton(
                                color: Colors.deepOrange.shade800,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),borderSide: BorderSide(
                                    color: Colors.deepOrange
                                )),
                                onPressed: () {
                                  cubit.get(context).sendMessage(
                                    date: DateTime.now().toString(),
                                    text: controller.text,
                                    receiverId: userModel.id,
                                  );
                                },
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is SuccessSendMessageState) {
              print("Success");

            }
            ;
          },
        );
      },
    );
  }
}
