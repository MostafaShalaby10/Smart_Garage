import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/states.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/dio/dio.dart';
import 'package:untitled/models/messageModel.dart';
import 'package:untitled/models/order_registration_model.dart';
import 'package:untitled/models/payment_reqeust_model.dart';
import 'package:untitled/sharedprefrences/sharedprefrences.dart';

import '../models/dataModel.dart';
import '../models/user_model.dart';
import '../shared.dart';

class cubit extends Cubit<states> {
  cubit() : super(initialstate());

  static cubit get(context) => BlocProvider.of(context);
  int counter = 1;
  UserModel? model;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(signuploadingstate());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      createUser(
        name: name,
        phone: phone,
        id: value.user!.uid,
        email: value.user!.email,
      );
      emit(signupsuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(signuperrorstate(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String phone,
    required String id,
    required String? email,
  }) {
    model = UserModel(
      email: email,
      id: id,
      name: name,
      phone: phone,
    );
    emit(createuserloadingstate());
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(model!.tomap())
        .then((value) {
      emit(createusersuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(createusererrorstate());
    });
  }

  void getUser() {
    emit(getuserloadingstate());
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedprefs.getdata(key: "UID"))
        .get()
        .then((value) {
      name = value.data()!['name'];
      phone = value.data()!['phone'];
      email = value.data()!['email'];
      // print(name);
      // print(phone);
      // print(sharedprefs.getdata(key: "UID"));
      emit(getusersuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(getusererrorstate());
    });
  }

  void update({
    required String namee,
    required String phonee,
  }) {
    emit(updateloadingstate());
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedprefs.getdata(key: "UID"))
        .update({
      "name": namee,
      "phone": phonee,
    }).then((value) {
      // print("ok");
      emit(updatesuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(updateerrorstate());
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(loginloadingstate());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      sharedprefs.savedata(key: "UID", value: value.user!.uid);
      // print(value.user!.email);
      // print(value.user!.uid);

      emit(loginsuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(loginerrorstate());
    });
  }

  void plus() {
    counter++;
    total = (counter * 5).toString();
    emit(counterchange());
  }

  void minus() {
    if (counter > 1) {
      counter--;
    } else {
      counter = 1;
    }
    total = (counter * 5).toString();
    emit(counterchange());
  }

  Future<void> getAuthToken() async {
    emit(paymentauthloadingstate());
    // print("asdkdsansa");
    dio.postdata(url: constants.authToken, data: {
      "api_key": constants.APIKEY,
    }).then((value) {
      constants.firstToken = value.data['token'];
      // print("the token is ${constants.firstToken}");
      emit(paymentauthsuccessstate());
    }).catchError((error) {
      // print("error");
      print(error.toString());
      emit(paymentautherrorstate());
    });
    // print("asdkdsadasasdawwdadsdsadassddsnsa");
  }

//   Future getOrder({
//     required String pricee,
//   }) async {
//     emit(getOrderloadingstate());
//     print("sdafewqw");
// print(constants.orderID);
// print(constants.firstToken);
// print(pricee);
//
//     dio.postdata(url: constants.orderID, data: {
//       'auth_token': constants.firstToken,
//       "delivery_needed": "false",
//       "amount_cents": 500,
//       "currency": "EGP",
//       "items": [],
//     }).then((value) {
//       constants.paymentOrderID = value.data["id"];
//       print("the order_token is ${constants.paymentOrderID}");
//       // getPaymentRequest(pricee: pricee);
//       emit(getOrdersuccessstate());
//     }).catchError((error) {
//       print(error.toString());
//       emit(getOrdererrorstate());
//     });
//   }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(getOrderloadingstate());
    dio.postdata(url: constants.orderID, data: {
      'auth_token': constants.firstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      OrderRegistrationModel orderRegistrationModel =
          OrderRegistrationModel.fromJson(value.data);
      constants.paymentOrderID = orderRegistrationModel.id.toString();
      getPaymentRequest(price, firstName, lastName, email, phone);
      // print('The order id 🍅 =${constants.paymentOrderID}');
      emit(getOrdersuccessstate());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️ ${error.toString()}');
      emit(
        getOrdererrorstate(),
      );
    });
  }

  // Future<void> getPaymentRequest({
  //   required String pricee,
  // }) async {
  //   emit(getpaymentloadingstate());
  //   print("hqwdbkjsahdhdsakhdaskjhdiwuqhdiuahckjb,znc,zxmv/zv");
  //   dio.postdata(
  //     url: constants.paymentID,
  //     data: {
  //       "auth_token": constants.firstToken,
  //       "delivery_needed": "false",
  //       "amount_cents": pricee,
  //       "currency": "EGP",
  //   "billing_data": {
  //     "email": email,
  //     "first_name": name,
  //     "phone_number": phone,
  //   },
  //       "order_id": constants.paymentOrderID,
  //       "items": [],
  //
  //       "integration_id": constants.cartID,
  //     },
  //   ).then((value) {
  //     constants.finalToken = value.data['token'];
  //     print("The final token is : ${constants.finalToken}");
  //     emit(getpaymentsuccessstate());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(getpaymenterrorstate());
  //   });
  // }
  Future<void> getPaymentRequest(
    String priceOrder,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    emit(getpaymentloadingstate());
    dio.postdata(
      url: constants.paymentID,
      data: {
        "auth_token": constants.firstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": constants.paymentOrderID,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": constants.cartID,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
          PaymentRequestModel.fromJson(value.data);
      constants.finalToken = paymentRequestModel.token;
      // print('Final token 🚀 ${constants.finalToken}');
      emit(getpaymentsuccessstate());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️${error.toString()}');
      emit(
        getpaymenterrorstate(),
      );
    });
  }

  Future<void> getRefCode() async {
    emit(getrefcodeloadingstate());
    dio.postdata(url: constants.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": constants.finalToken,
    }).then((value) {
      // print("Success!!!!!!!!!!!!!!");
      constants.refCode = value.data['id'];
      // print(constants.refCode);
      emit(getrefcodesuccessstate());
    }).catchError((error) {
      print(error.toString());
      emit(getrefcodeerrorstate());
    });
  }

  Duration durationP1 = Duration();
  Timer? timerP1;
  bool timerFlagP1 = false;

  void stopWatch() {
    if (timerFlagP1 == false) {
      timerP1 = Timer.periodic(Duration(seconds: 1), (_) => addTime());
      timerFlagP1 = true;
    }
  }

  void addTime() {
    final seconds = durationP1.inSeconds + 1;
    durationP1 = Duration(seconds: seconds);
    emit(StartTimerState());
  }

  void cancelWatch() {
    if (timerFlagP1 == true) {
      timerP1?.cancel();
      timerFlagP1 == false;
      emit(StopTimerState());
    }
  }

  MessageModel? messageModel;

  void sendMessage({
    required String date,
    required String text,
    String? receiverId,
  }) {
    messageModel = MessageModel(
      date: date,
      text: text,
      receiverId: receiverId,
      senderId: sharedprefs.getdata(key: "UID"),
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedprefs.getdata(key: "UID"))
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel!.tomap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("Chats")
        .doc(sharedprefs.getdata(key: "UID"))
        .collection("Messages")
        .add(messageModel!.tomap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
  }

  List<dynamic> messages = [];

  void getMessages({
    String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedprefs.getdata(key: "UID"))
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("date")
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromjson(element.data()));
      });
      // emit(SuccessGetMessageState());
    });
  }

  List<dynamic> users = [];

  void getUsers() {
    emit(LoadingGetUsersState());
    users = [];
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        // print(sharedprefs.getdata(key: "UID"));
        if (sharedprefs.getdata(key: "UID") != element.data()["id"])
          users.add(UserModel.fromjson(element.data()));
        // print("jgjgj");
      });
      emit(SuccessGetUsersState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUsersState());
    });
  }

  DataModel? dataModel;

  String? rate;

  void changeRate(double value) {
    rate = value.toString();
    emit(ChangeRate());
  }

  void saveUserData({
    required String price,
    required String period,
    required String location,
    required String date,
    // String? rate,
  }) {
    // print(rate);
    dataModel = DataModel(
      name: name,
      phone: phone,
      email: email,
      price: price,
      period: period,
      location: location,
      id: sharedprefs.getdata(key: "UID"),
      date: date,
      rate: rate,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedprefs.getdata(key: "UID"))
        .collection("Data")
        .add(dataModel!.tomap())
        .then((value) {
      emit(SuccessSaveDataState());
    }).catchError((error) {
      emit(ErrorSaveDataState());
    });
  }

  List<dynamic> userData = [];

  void getUserData({
    String? userId,
  }) {
    // print("dsakdlsada");
    emit(LoadingGetDataState());
    users = [];
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("Data")
        .get()
        .then((value) {
      // print(value.docs.length);
      value.docs.forEach((element) {
        // print(element.data());
        userData.add(DataModel.fromjson(element.data()));
        // print(userData.length);
      });
      emit(SuccessGetDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetDataState());
    });
  }

  Map<dynamic, dynamic>? map;

  void readDataPublic() async {
    publicCounter = 0 ;
    emit(LoadingGetPublicDataState());
    // final ref = FirebaseDatabase.instance.ref();
    await ref.child('garage1').get().then((value) {
      publicMap = value.value as Map;
      publicMap?.forEach((key, value) {
        if(value==true)
          publicCounter++;
      });
      emit(SuccessGetPublicDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetPublicDataState());
    });

    //   if (snapshot.exists) {
    //     map = snapshot.value as Map ;
    //     print(map);
    //     emit(SuccessGetPublicDataState());
    //   } else {
    //     print('No data available.');
    //   }
    // }
  }

  void readDataPrivate() async {
    privateCounter = 0 ;
    emit(LoadingGetPublicDataState());
    // final ref = FirebaseDatabase.instance.ref();
    await ref.child('garage2').get().then((value) {
      privateMap = value.value as Map;
      privateMap?.forEach((key, value) {
        if(value==true)
          privateCounter++;
      });
      // print(map!["P1"]);/
      emit(SuccessGetPublicDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetPublicDataState());
    });

    //   if (snapshot.exists) {
    //     map = snapshot.value as Map ;
    //     print(map);
    //     emit(SuccessGetPublicDataState());
    //   } else {
    //     print('No data available.');
    //   }
    // }
  }

  void writeData({required String location}) async
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref("garage2");

    await ref.update({
      location : false
    });
  }

}
