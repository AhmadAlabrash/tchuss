import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tchuss/component/components.dart';
import 'package:tchuss/home/myhome.dart';
import 'package:tchuss/login/cubit/cubit.dart';
import 'package:tchuss/login/cubit/state.dart';
import 'package:tchuss/register/register.dart';
import 'package:tchuss/shared/cache.dart';

class Login extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Cubitloginsocial(),
      child: BlocConsumer<Cubitloginsocial, Statesociallogin>(
        listener: (context, state) {
          if (state is Loginsuccess) {
            Sharedprefrenceslocal.putdata(word: 'uid', valueofword: state.la);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false);
          }
        },
        builder: (context, state) => Expanded(
          child: Scaffold(
            appBar: AppBar(
                // title: Text(
                //   'LogIn',
                //   style: TextStyle(color: Colors.black),
                // ),
                ),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text('LogIn',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Now we will browse our online shop',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(
                        height: 50,
                      ),
                      defulttextform(
                        preficon: Icon(Icons.email),
                        label: 'Email',
                        control: emailcontroller,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defulttextform(
                          preficon: Icon(Icons.lock),
                          label: 'Password',
                          control: passwordcontroller,
                          suficon: Icon(Icons.remove_red_eye),
                          invisible: true),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.deepOrange,
                        child: TextButton(
                          onPressed: () {
                            Cubitloginsocial.getdata(context).senddatalogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text);
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You do not have account ? ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Registerdata()),
                                    (route) => false);
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
