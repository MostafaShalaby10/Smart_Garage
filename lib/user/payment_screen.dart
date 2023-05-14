import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/bloc/cubit.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/shared.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';
import 'package:untitled/user/toggle_screen.dart';

class payment extends StatefulWidget {
  final String location;

  payment({super.key, required this.location});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    if(sharedprefs.getdata(key: "rate")!=true)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (BuildContext context)=>dialog(context)) ;
    });

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, states>(
      builder: (context, state) {
        // showDialog(context: context, builder: (BuildContext context)=>dialog(context));
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(children: [
                  Container(
                    child: Image(
                      height: 300,
                      image: AssetImage("lib/images/5.jpg"),
                    ),
                  ),
                  ConditionalBuilder(
                    condition: state is! paymentauthloadingstate,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.email,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${email}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${name}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.phone,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${phone}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              // Spacer(),
                              // IconButton(onPressed: (){},
                              //     icon: Icon(
                              //       Icons.edit
                              //     ),)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.monetization_on,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "${total}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              // Spacer(),
                              // IconButton(onPressed: (){},
                              //     icon: Icon(
                              //       Icons.edit
                              //     ),)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          ConditionalBuilder(
                            condition: state is! getOrderloadingstate,
                            builder: (context) => button(
                                context: context,
                                text: "Check out",
                                function: () {
                                  cubit.get(context).saveUserData(
                                        price: total,
                                        period:
                                            (int.parse(total) / 5).toString(),
                                        location: widget.location,
                                        date: DateTime.now().toString(),

                                    // rate: cubit.get(context).rate
                                      );
                                  cubit.get(context).getOrderRegistrationID(
                                      price: total,
                                      firstName: name,
                                      lastName: name,
                                      phone: phone,
                                      email: email);
                                }),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is getpaymentsuccessstate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => toggle()));
              cubit.get(context).writeData(location: widget.location) ;
        }
        if (state is getpaymenterrorstate) {}
      },
    );
  }

  Widget dialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rate us',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RatingBar.builder(
                    // initialRating: 3,
                    minRating: 1,
                    itemSize: 40,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      cubit.get(context).changeRate(rating);
                    },
                  ),
                  if (cubit.get(context).rate != null)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                          ),
                          onPressed: () {
                            sharedprefs.savedata(key: "rate", value: true);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    )
                ],
              )),
          IconButton(onPressed: () {}, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}
