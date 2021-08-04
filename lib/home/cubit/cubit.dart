import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/messagemodel.dart';
import 'package:tchuss/model/postmodel.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/news/news.dart';
import 'package:tchuss/settings/settings.dart';
import 'package:tchuss/notification/notification.dart';
import 'package:tchuss/users/users.dart';

class Cubithomesocial extends Cubit<Stateshome> {
  Cubithomesocial() : super(Iniatialsocialhome());
  Usermodel? user;

  var currintindex = 0;
  List<Widget> screens = [News(), Users(), Notifications(), Setting()];

  static Cubithomesocial getdata(context) => BlocProvider.of(context);
  void changenavbar(id) {
    currintindex = id;
    emit(Homechangebottom());
  }

  void getdatahome({@required uid}) {
    emit(Getdataloading());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      user = Usermodel.fromJson(value.data());
      emit(Getdatasuccess(user));
      print('all home data come now!!!!!!!!!!!!!!!');
      print(user!.isverficatedemail);
    }).catchError((error) {
      emit(Getdatafailed());
      print('Error beccccccccccc $error');
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(Getimagesuccess());
      uploadimage();
    } else {
      print('No image selected.');
      emit(Getimagefailed());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    var pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(Getimagecoversuccess());
      uploadcoverimage();
    } else {
      print('No image selected.');
      emit(Getimagecoverfailed());
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    var pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(Getimagepostsuccess());
    } else {
      print('No image selected.');
      emit(Getimagepostfailed());
    }
  }

  void uploadimage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        updateuser(word: 'image', value: value);
      }).catchError((er) {});
      emit(Postimagesuccess());
    }).catchError((er) => emit(Postimagefailed()));
  }

  void uploadcoverimage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        updateuser(word: 'cover', value: value);
        print(value);
      }).catchError(() {});
      emit(Postimagecoversuccess());
    }).catchError((er) => emit(Postimagecoverfailed()));
  }

  void updateuser({@required word, @required value}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({word: value}).then((value) {
      emit(Uploadsuccess());
      getdatahome(uid: user!.uid);
    }).catchError((er) => emit(Uploadfailed()));
  }

  void updateuserdata(
      {@required namevalue, @required biovalue, @required phonevalue}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'phone': phonevalue, 'name': namevalue, 'bio': biovalue}).then(
            (value) {
      emit(Uploaddatasuccess());
      getdatahome(uid: user!.uid);
    }).catchError((er) {
      print('ERRRRRRRRRRRRRRR is $er');

      emit(Uploaddatafailed());
    });
  }

  Postmodel? postdata;

  void uploadpostdataandimage({@required content, @required date}) {
    emit(Postloading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance.collection('posts').add({
          'name': user!.name,
          'uid': user!.uid,
          'image': user!.image,
          'content': content,
          'date': date,
          'postimage': value
        }).then((value) {
          emit(Postpostsuccess());
        }).catchError((error) => emit(Postpostfailed()));

        print(value);
      });
      emit(Postimagecoversuccess());
    }).catchError((er) => emit(Postimagecoverfailed()));
  }

  void createpostdata({@required content, @required date}) {
    emit(Postloadingnoimage());
    FirebaseFirestore.instance.collection('posts').add({
      'name': user!.name,
      'uid': user!.uid,
      'image': user!.image,
      'content': content,
      'date': date,
      'postimage': ''
    }).then((value) {
      emit(Postpostsuccess());
    }).catchError((error) => emit(Postpostfailed()));
  }

  void removepostimage() {
    postImage = null;
    emit(RemoveImage());
  }

  List<Postmodel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  void getposts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((val) {
          likes.add(val.docs.length);
          posts.add(Postmodel.fromJson(element.data()));
          postId.add(element.id);
        });

        //  likes.add(element.reference.collection('likes').id);
      });
      emit(Getpostsuccess());
    }).catchError((er) {
      emit(Getpostfailed());
    });
  }

  void postlike({@required mypostid}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(mypostid)
        .collection('likes')
        .doc(user!.uid)
        .set({'Like': true}).then((value) {
      emit(Postlikesuccess());
    }).catchError((er) {
      emit(Postilikefailed());
    });
  }

  List<Usermodel> allusers = [];
  void getusers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (user!.uid != element.data()["uid"])
          allusers.add(Usermodel.fromJson(element.data()));
        emit(Getalluserssuccess());
      });
    }).catchError((error) {
      emit(Getallusersfailed());
    });
  }

  void postmessage(
      {@required reciverid, @required textmessage, @required dateofsend}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .doc(reciverid)
        .collection('messages')
        .add({
      'reciverid': reciverid,
      'text': textmessage,
      'date': dateofsend.toString()
    }).then((value) {
      postmessageanotheruser(
          reciverid: reciverid,
          dateofsend: dateofsend,
          textmessage: textmessage);
      emit(Sendmessagesuccess());
    }).catchError((er) {
      emit(Sendmessagefailed());
    });
  }

  void postmessageanotheruser(
      {@required reciverid, @required textmessage, @required dateofsend}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverid)
        .collection('chats')
        .doc(user!.uid)
        .collection('messages')
        .add({
      'reciverid': reciverid,
      'text': textmessage,
      'date': dateofsend.toString()
    }).then((value) {
      emit(Sendmessageanothersuccess());
    }).catchError((er) {
      emit(Sendmessageanotherfailed());
    });
  }

  List<Messagemodel> messages = [];
  void getmessages({@required reciverid}) {
    // messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('chats')
        .doc(reciverid)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(Messagemodel.fromJson(element.data()));
      });
      emit(Getmessages());
    });
  }
}
