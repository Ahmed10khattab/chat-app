 
 
import 'package:chat1/Screens/Login.dart';
import 'package:chat1/Screens/ch.dart';
import 'package:chat1/Screens/chatScreen.dart';
import 'package:chat1/SinUp.dart';
import 'package:chat1/firebase.dart/auth.dart';
import 'package:chat1/provider/CurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
final fire =  FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
   

    return  
       
              MaterialApp(
                     home: LogIn(),
                    initialRoute:fire.currentUser !=null?ChatScreen.chatscreen:LogIn.login ,
                     routes: {
              LogIn.login: (context) => LogIn(),
              SignUp.signup: (context) => SignUp(),
              
              ChatScreen.chatscreen: (context) => ChatScreen()
                     },
                     
              
                 
           );
  }
}
