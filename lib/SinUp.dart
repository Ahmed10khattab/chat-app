import 'package:chat1/firebase.dart/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino(1).dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material(1).dart';

import 'Screens/chatScreen.dart';

class SignUp extends StatefulWidget {
  static String signup = 'SignUp';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _LogInState();
}

class _LogInState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  // void validation() {
  //   var current = formstate.currentState;
  //   if (current!.validate()) {
  //     current.save();
  //   }
  // }

  late TextEditingController password;
  late TextEditingController email;

  @override
  void initState() {
    password = TextEditingController();
    email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
     password.dispose();
    email.dispose();
   
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 233, 240),
      body: Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * .16, left: (width * .05)),
                    child: Container(
                      height: height * .4,
                      width: width * .4,
                      child: Column(
                        children: [
                          Image(image: AssetImage('lib/images/p1 (2).png')),
                          Padding(
                            padding: EdgeInsets.only(top: height * .07),
                            child: Text(
                              'Chat App',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'enter new e-mail';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'create new email',
                        prefixIcon: Icon(Icons.email),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 33, 33)))),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'enter password';
                      } else if (val.length < 6) {
                        return 'enter at least 7 number or character';
                      }
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: ' create password',
                        prefixIcon: Icon(Icons.password_rounded),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 33, 33))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 243, 33, 33)))),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Builder(builder: (context) {
                    return MaterialButton(
                      onPressed: () async {
                        var current = formstate.currentState;
                        if (current!.validate()) {
                          current.save();
                          loading(true);

                          try {
                            FirebaseAuth fire = FirebaseAuth.instance;
                            await fire.createUserWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim());
                            User ?SignupUser = fire.currentUser;
                            Navigator.pushNamed(context, ChatScreen.chatscreen,arguments: SignupUser!.email);
                          } catch (e) {
                            loading(false);
                            print(e);
                            Scaffold.of(context).showSnackBar(const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 44, 43, 43),
                                content: Text(
                                  'The email address is already in use by another account ',
                                )));
                          }
                        } else {
                          return null;
                        }
                        //   Auth.auth
                        //       .signUp(password: password.text, email: email.text);
                      },
                      child: Text('Sign Up'),
                      elevation: 10,
                      color: Color.fromARGB(255, 118, 152, 168),
                      height: height * .05,
                      minWidth: width * .3,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool i = false;
  loading(i) {
    if (i) {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 8, 171, 247),
                ),
              ));
    } else {
      return null;
    }
  }
}
