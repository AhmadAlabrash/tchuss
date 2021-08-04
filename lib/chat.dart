import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/messagemodel.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

var textmessage = TextEditingController();

class Chats extends StatelessWidget {
  //var textmessage =TextEditingController();
  Usermodel mod;
  Chats(this.mod);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(IconBroken.Arrow___Left_2)),
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage('${mod.image}')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${mod.name}',
                      style: TextStyle(fontSize: 19),
                    ),
                  ],
                ),
                actions: [],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ConditionalBuilder(
                      condition:
                          Cubithomesocial.getdata(context).messages != null,
                      builder: (context) => ListView.separated(
                          itemBuilder: (context, index) {
                            if (mod.uid ==
                                Cubithomesocial.getdata(context)
                                    .messages[index]
                                    .reciverid)
                              return mymessage(Cubithomesocial.getdata(context)
                                  .messages[index]);
                            return anothermessage(
                                Cubithomesocial.getdata(context)
                                    .messages[index]);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                          itemCount:
                              Cubithomesocial.getdata(context).messages.length),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textmessage,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(IconBroken.Chat),
                                hintText: 'Write your message ...'),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Cubithomesocial.getdata(context).postmessage(
                                  reciverid: mod.uid,
                                  textmessage: textmessage.text,
                                  dateofsend: DateTime.now());
                              textmessage.text = '';
                            },
                            icon: Icon(
                              IconBroken.Send,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}

Widget mymessage(Messagemodel msg) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
            child: Text(
              '${msg.text}',
              style: TextStyle(fontSize: 15),
            )),
      ),
    );

Widget anothermessage(Messagemodel msg) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadiusDirectional.all(Radius.circular(10))),
            child: Text(
              '${msg.text}',
              style: TextStyle(fontSize: 15),
            )),
      ),
    );
