import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/chat.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {},
        builder: (context, state) => ConditionalBuilder(
              condition: Cubithomesocial.getdata(context).allusers != null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => user(
                      Cubithomesocial.getdata(context).allusers[index],
                      context),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ),
                  itemCount: Cubithomesocial.getdata(context).allusers.length),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ));
  }
}

Widget user(Usermodel model, context) => InkWell(
      onTap: () {
        Cubithomesocial.getdata(context).getmessages(reciverid: model.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Chats(model)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
                radius: 28, backgroundImage: NetworkImage('${model.image}')),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${model.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 2, fontSize: 18),
                    ),
                    SizedBox(width: 7),
                  ],
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(IconBroken.More_Square),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
