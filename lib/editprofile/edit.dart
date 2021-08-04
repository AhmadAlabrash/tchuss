import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/component/components.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

class Edit extends StatelessWidget {
  var namecontrol = TextEditingController();
  var biocontrol = TextEditingController();
  var phonecontrol = TextEditingController();

  Usermodel? model;
  @override
  Widget build(BuildContext context) {
    model = Cubithomesocial.getdata(context).user;
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {},
        builder: (context, state) {
          var primage = Cubithomesocial.getdata(context).profileImage;
          var coverimage = Cubithomesocial.getdata(context).coverImage;
          namecontrol.text = model!.name.toString();
          biocontrol.text = model!.bio.toString();
          phonecontrol.text = model!.phone.toString();

          return ConditionalBuilder(
              condition: model != null,
              builder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 260,
                            child: Stack(
                              clipBehavior: Clip.antiAlias,
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(
                                  height: 220,
                                  width: double.infinity,
                                  child: Image(
                                    image: coverimage == null
                                        ? NetworkImage('${model!.cover}')
                                        : FileImage(coverimage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: CircleAvatar(
                                      radius: 18,
                                      child: IconButton(
                                          onPressed: () {
                                            Cubithomesocial.getdata(context)
                                                .getCoverImage();
                                          },
                                          icon: Icon(
                                            IconBroken.Edit,
                                            size: 15,
                                          ))),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 64,
                                    child: CircleAvatar(
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.lightBlue,
                                            child: IconButton(
                                                onPressed: () {
                                                  Cubithomesocial.getdata(
                                                          context)
                                                      .getProfileImage();
                                                },
                                                icon: Icon(
                                                  IconBroken.Edit,
                                                  size: 15,
                                                ))),
                                      ),
                                      radius: 60,
                                      backgroundImage: primage == null
                                          ? NetworkImage('${model!.image}')
                                          : FileImage(primage) as ImageProvider,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: defulttextform(
                                preficon: Icon(IconBroken.User),
                                label: 'Name',
                                control: namecontrol),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: defulttextform(
                                preficon: Icon(IconBroken.Star),
                                label: 'Bio',
                                control: biocontrol),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: defulttextform(
                                preficon: Icon(IconBroken.Call),
                                label: 'Phone',
                                control: phonecontrol),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Cubithomesocial.getdata(context).updateuserdata(
                                    namevalue: namecontrol.text,
                                    biovalue: biocontrol.text,
                                    phonevalue: phonecontrol.text);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Text('Update My Profile'),
                              ))
                        ],
                      ),
                    ),
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}
