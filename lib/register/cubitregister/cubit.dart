import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/register/cubitregister/states.dart';

class Cubitsocialregister extends Cubit<Statesocialregister> {
  Cubitsocialregister() : super(Iniatialshop());

  static Cubitsocialregister getdata(context) => BlocProvider.of(context);

  Usermodel? user;

  senddataregister({
    @required name,
    @required phone,
    @required email,
    @required password,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createuser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          uid: value.user!.uid);
      print('okkkkkkkkkkkkkk');
      print(value.user!.email);

      emit(Registersuccess(value.user!.uid));
    }).catchError((error) {
      emit(Registerfailed());
      print('Hi      iiiError beccccccccccc $error');
    });
  }

  void createuser(
      {@required uid,
      @required name,
      @required phone,
      @required email,
      @required password,
      isemailvercated = false}) {
    user = Usermodel(
        uid: uid,
        name: name,
        email: email,
        password: password,
        phone: phone,
        bio: 'Write Your bio ...',
        image:
            'https://i.pinimg.com/originals/b8/bf/c6/b8bfc6600cfcb6e3b665af3adfdb7a6e.jpg',
        isverficatedemail: isemailvercated);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(user!.tomap())
        .then((value) {
      print('okkkkkkkkkkkkkk');

      emit(Createusersuccess());
    }).catchError((error) {
      emit(Createuserfailed());
      print('Hi      firebase beccccccccccc $error');
    });
  }
}
