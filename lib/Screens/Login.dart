import 'package:chat1/Screens/chatScreen.dart';
import 'package:chat1/SinUp.dart';
import 'package:chat1/firebase.dart/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material(1).dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool keepMeLogin = false;
bool li=false;

class LogIn extends StatefulWidget {
  static String login = 'loginScreen';
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  static bool male = false;

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

    // bool showSpiner = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 233, 240),
      body: Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              Column(
                children: [
                  Switch(
                      value: (male),
                      onChanged: (val) {
                        setState(() {
                          male = val;
                         
                        });
                         li = male;
                      }),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * .16, left: (width * .05)),
                    child: Container(
                      height: height * .4,
                      width: width * .4,
                      child: Column(
                        children: [
                          const Image(
                              image: AssetImage('lib/images/p1 (2).png')),
                          Padding(
                            padding: EdgeInsets.only(top: height * .07),
                            child: const Text(
                              'Chat App',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 25),
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
                        return 'enter your email';
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'enter your email',
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.blue))),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  TextFormField(
                    controller: password,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter password';
                      } else if (val.length <= 6) {
                        return 'at  least 7 numbers or character';
                      }
                    },
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'enter your password',
                        prefixIcon: const Icon(Icons.password_rounded),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 4, 98, 192))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.blue))),
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

                          try {
                            loading(true);
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim());
                            User? user2 = auth.currentUser;

                            Navigator.pushNamed(context, ChatScreen.chatscreen,
                                arguments: user2!.email);

                            //

                            // setState(() {
                            //   showSpiner = false;

                            // });

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              Fluttertoast.showToast(
                                  msg: ' the Email is wrong');
                            } else if (e.code == 'wrong-password') {
                              Fluttertoast.showToast(
                                  msg: 'the password is worng');
                            }
                          }
                        } else {
                          Scaffold.of(context).showSnackBar(const SnackBar(
                              content: Text(
                            'enter your email and password',
                          )));
                        }
                      },
                      child: const Text('Sign In'),
                      elevation: 10,
                      color: const Color.fromARGB(255, 118, 152, 168),
                      height: height * .05,
                      minWidth: width * .3,
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: height * .06),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.signup);
                      },
                      child: Container(
                          height: 40,
                          width: 100,
                          color: const Color.fromARGB(255, 250, 250, 250),
                          child: const Center(
                              child: Text(
                            'Sign up !',
                            style: TextStyle(fontSize: 20),
                          ))),
                    ),
                  )
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

  // KeepMeLogin() async {
  //   SharedPreferences prefrence = await SharedPreferences.getInstance();
  //   prefrence.setBool('keepMeLogin', keepMeLogin);
  // }
}
