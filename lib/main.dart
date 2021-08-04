import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/home/myhome.dart';
import 'package:tchuss/login/login.dart';
import 'package:tchuss/shared/cache.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      // statusBarColor: Colors.pink, // status bar color
      statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseAuth.instance;
  await Sharedprefrenceslocal.initshared();
  dynamic uid = await Sharedprefrenceslocal.getdata(word: 'uid');
  Widget startWidget;
  if (uid != null) {
    startWidget = Home();
  } else {
    startWidget = Login();
  }

  runApp(MyApp(uid, startWidget));
}

class MyApp extends StatelessWidget {
  dynamic uid;
  Widget startWidget;
  MyApp(this.uid, this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Cubithomesocial()
        ..getposts()
        ..getdatahome(uid: uid)
        ..getusers(),
      child: BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          themeMode: ThemeMode.light,
          home: startWidget,
        ),
      ),
    );
  }
}
