import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

class Post extends StatelessWidget {
  Usermodel? model;
  dynamic contenttext = TextEditingController();
  dynamic date;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {
      if (state is Getdatasuccess) {}
    }, builder: (context, state) {
      model = Cubithomesocial.getdata(context).user;
      date = DateTime.now();

      //  contenttext = 'What Are You Think About ...';

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(IconBroken.Arrow___Left_2),
            onPressed: () {
              Cubithomesocial.getdata(context).removepostimage();
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Add Post',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  print(contenttext.text);
                  if (Cubithomesocial.getdata(context).postImage != null) {
                    Cubithomesocial.getdata(context).uploadpostdataandimage(
                        content: contenttext.text, date: date.toString());
                  } else {
                    Cubithomesocial.getdata(context).createpostdata(
                        content: contenttext.text, date: date.toString());
                  }
                },
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.blueAccent),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (state is Postloadingnoimage || state is Postloading)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage('${model!.image}')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Ahmad Alabrash',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 2, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 100,
                    child: TextFormField(
                      controller: contenttext,
                      decoration: InputDecoration(
                          hintText: 'Whats on your mind ...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                if (Cubithomesocial.getdata(context).postImage != null)
                  Container(
                    width: double.infinity,
                    height: 180,
                    child: Image(
                      fit: BoxFit.cover,
                      image: FileImage(
                          Cubithomesocial.getdata(context).postImage!),
                    ),
                  ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconBroken.Graph,
                      color: Colors.blueAccent,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Cubithomesocial.getdata(context).getPostImage();
                        },
                        child: Text(
                          'Choose A Photo',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 1,
                    color: Colors.grey[400],
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
