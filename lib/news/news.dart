import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/home/cubit/cubit.dart';
import 'package:tchuss/home/cubit/state.dart';
import 'package:tchuss/model/postmodel.dart';
import 'package:tchuss/network/styles/icon_broken.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubithomesocial, Stateshome>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: Cubithomesocial.getdata(context).posts != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.freepik.com/free-photo/ecstatic-white-girl-beret-posing-with-amazement-elegant-caucasian-female-model-t-shirt-standing-red-wall_197531-11462.jpg'),
                    ),
                  ),
                  Text(
                    '  Communcate With Your Friends Now',
                    style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                  width: double.infinity,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => itempost(
                          Cubithomesocial.getdata(context).posts[index],
                          Cubithomesocial.getdata(context).postId[index],
                          Cubithomesocial.getdata(context).likes[index],
                          context),
                      separatorBuilder: (context, index) => Container(
                            height: 10,
                          ),
                      itemCount:
                          Cubithomesocial.getdata(context).posts.length)),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget itempost(Postmodel model, String postid, int likes, context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage('${model.image}')),
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
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.blue,
                          )
                        ],
                      ),
                      Text(
                        ' ${model.date}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 0.6),
                      )
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(IconBroken.More_Square),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text('${model.content}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1)),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 1,
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        '#Philstine_Under_Attack',
                        style: TextStyle(color: Colors.blue, height: 1),
                      ),
                      onPressed: () {}),
                  MaterialButton(
                      minWidth: 1,
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        '#Syria_now',
                        style: TextStyle(color: Colors.blue, height: 1),
                      ),
                      onPressed: () {}),
                ],
              ),
              if (model.postimage != '')
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Image(
                    image: NetworkImage('${model.postimage}'),
                  ),
                ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '243 Like',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '43 Comments',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${Cubithomesocial.getdata(context).user!.image}')),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Write a comment ...',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 12),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(IconBroken.Chat),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Comment',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Cubithomesocial.getdata(context)
                            .postlike(mypostid: postid);
                      },
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$likes',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
