import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/network/styles/icon_broken.dart';
import 'package:tchuss/post/post.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {
          // if (state is Homepost) {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => Post()));
          //}
        },
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: Text('FeedBook',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
                actions: [
                  IconButton(
                      icon: Icon(IconBroken.Paper_Upload),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Post()));
                      }),
                  IconButton(
                    icon: Icon(IconBroken.More_Circle),
                    onPressed: () {},
                  )
                ],
              ),
              body: Cubithomesocial.getdata(context)
                  .screens[Cubithomesocial.getdata(context).currintindex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: Cubithomesocial.getdata(context).currintindex,
                onTap: (value) =>
                    Cubithomesocial.getdata(context).changenavbar(value),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Chat), label: 'Chats'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Notification),
                      label: 'Notifications'),
                  BottomNavigationBarItem(
                      icon: Icon(IconBroken.Setting), label: 'Settings'),
                ],
              ),
            ));
  }
}
