import 'package:bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/login/cubit/state.dart';

class Cubitloginsocial extends Cubit<Statesociallogin> {
  Cubitloginsocial() : super(Iniatialsocial());
  dynamic user;

  static Cubitloginsocial getdata(context) => BlocProvider.of(context);

  senddatalogin({
    @required email,
    @required password,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);

      emit(Loginsuccess(value.user!.uid));
    }).catchError((error) {
      emit(Loginfailed());
      print('Error beccccccccccc $error');
    });
  }
}
