import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchuss/component/components.dart';
import 'package:tchuss/home/myhome.dart';
import 'package:tchuss/register/cubitregister/cubit.dart';
import 'package:tchuss/register/cubitregister/states.dart';
import 'package:tchuss/shared/cache.dart';

class Registerdata extends StatelessWidget {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitsocialregister(),
      child: BlocConsumer<Cubitsocialregister, Statesocialregister>(
        listener: (BuildContext context, state) {
          if (state is Registersuccess) {
            Sharedprefrenceslocal.putdata(word: 'uid', valueofword: state.la);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false);
          }
        },
        builder: (BuildContext context, Object? state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  defulttextform(
                      preficon: Icon(Icons.person),
                      label: 'Name',
                      control: namecontroller),
                  SizedBox(
                    height: 20,
                  ),
                  defulttextform(
                      preficon: Icon(Icons.phone),
                      label: 'Phone',
                      control: phonecontroller,
                      invisible: false),
                  SizedBox(
                    height: 20,
                  ),
                  defulttextform(
                      preficon: Icon(Icons.email),
                      label: 'Email Address',
                      control: emailcontroller),
                  SizedBox(
                    height: 20,
                  ),
                  defulttextform(
                      preficon: Icon(Icons.phone),
                      label: 'Password',
                      control: passwordcontroller,
                      invisible: false),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.blueAccent,
                    child: TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Cubitsocialregister.getdata(context)
                                .senddataregister(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
