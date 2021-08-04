import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/editprofile/edit.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/usermodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

class Setting extends StatelessWidget {
  Usermodel? model;
  @override
  Widget build(BuildContext context) {
    model = Cubithomesocial.getdata(context).user;
    return BlocConsumer<Cubithomesocial, Stateshome>(
        listener: (context, state) {
          if (state is Getdatasuccess) {}
        },
        builder: (context, state) => ConditionalBuilder(
            condition: model != null,
            builder: (context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 240,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            child: Image(
                              image: NetworkImage('${model!.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 64,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage('${model!.image}'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '${model!.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(height: 1.5),
                    ),
                    Text(
                      '${model!.bio}',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.2),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Posts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(height: 1.5),
                                  ),
                                  Text(
                                    '126',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Posts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(height: 1.5),
                                  ),
                                  Text(
                                    '126',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    'Posts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(height: 1.5),
                                  ),
                                  Text(
                                    '126',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Edit()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 4),
                                  child: Text(
                                    'Profile Edit',
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                                onPressed: () {}, child: Icon(IconBroken.Edit)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            fallback: (context) => Center(child: CircularProgressIndicator())));
  }
}
