import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:chat1/Screens/Login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat1/SinUp.dart';
import 'package:chat1/custom/meassge.dart';
import 'package:chat1/firebase.dart/auth.dart';
import 'package:chat1/firebase.dart/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino(1).dart';
import 'package:flutter/material(1).dart';

var url;

class ChatScreen extends StatefulWidget {
  static String chatscreen = 'chatscreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

File? file;
var picket = ImagePicker();
UpLoading(bool image) async {
  var SelectedImage = await picket.getImage(
      source: image ? ImageSource.camera : ImageSource.gallery);
  if (SelectedImage != null) {
    file = File(SelectedImage.path);
    var rondom = Random().nextInt(10000000);
    var nameImage = basename(SelectedImage.path);
    nameImage = "$rondom $nameImage";

    var storage = FirebaseStorage.instance.ref('$nameImage');
    await storage.putFile(file!);
    url = await storage.getDownloadURL();
    print(url + 'object;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
  }
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  // validation() {
  //   var state = formstate.currentState;
  //   if (state!.validate()) {
  //     state.save();
  //   }
  // }

  final textClean = TextEditingController();
  final auth = FirebaseAuth.instance;
  //late User usersign = usersign;
  // void GetCurrentUser() {
  //   final user = auth.currentUser;
  //   if (user != null) {
  //     usersign = user;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    Stream<QuerySnapshot> Data =
        store.collection('Message').orderBy('time').snapshots();
    String? message;
    String user2 = ModalRoute.of(context)!.settings.arguments.toString();
    var SignUpUser = ModalRoute.of(context)!.settings.arguments.toString();
    var currentuser = user2;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 146, 146),
        actions: [
          IconButton(
              onPressed: () {
                Auth.auth.SignOut();
                Navigator.popAndPushNamed(context, LogIn.login);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
        toolbarHeight: 80,
        title: Row(
          children: const [
            Text('Chat'),
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('lib/images/p1 (2).png'),
              backgroundColor: Colors.black,
            )
          ],
        ),
      ),
      body: Form(
        key: formstate,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Data, // store.collection('Message').snapshots(),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Text('loading...'));
                    }
                    var data = snapshot.data;

                       
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                          reverse: true,
                        itemCount: data!.size ,
                        itemBuilder: (context, index) {
                          if (currentuser ==
                              '${data.docs[index]['user']}@yahoo.com') {}
                          return Message(
                              delete: () {
                                FireStore.firestore.delete(data.docs[index].id);
                              },
                              SignUpUser: SignUpUser ==
                                  '${data.docs[index]['user']}@yahoo.com',
                              isme: currentuser ==
                                  '${data.docs[index]['user']}@yahoo.com',
                              name: '${data.docs[index]['user']}',
                              // image: '${data.docs[index]['image']}' ,
                              massge: '${data.docs[index]['msg']}');
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'enter message';
                          }
                        },
                        controller: textClean,
                        onChanged: ((value) {
                          message = value;
                        }),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 253, 239, 239),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (Context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 100,
                                            child: Stack(
                                              children: [
                                                Column(children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      UpLoading(true);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.camera_alt),
                                                        Text('Camera'),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                                Positioned(
                                                  left: 160,
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          UpLoading(false);
                                                        },
                                                        child: Column(
                                                          children:const [
                                                            Icon(Icons.photo),
                                                            Text('Gallery'),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 70,
                                                    left: 110,
                                                    child: GestureDetector(
                                                        onTap: () {},
                                                        child: Text('cancel'))),
                                                Positioned(
                                                    top: 70,
                                                    left: 190,
                                                    child: GestureDetector(
                                                        onTap: () {},
                                                        child: Text('send')))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.camera_enhance)),
                            hintText: 'write a message',
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(30)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          var valid = formstate.currentState;
                          if (valid!.validate()) {
                            valid.save();

                            textClean.clear();
                            await store
                                .collection('Message')
                                .doc(Random().nextDouble().toString())
                                .set({
                              'time': FieldValue.serverTimestamp(),
                              'msg': message,
                              "image": url,
                              'user': user2.replaceFirst('@yahoo.com', ''),
                            });
                          }
                        },
                        icon: const Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: GestureDetector(
//                                                     onTap: () {
//                                                       UpLoading(false);
//                                                     },
//                                                     child: Column(
//                                                       children: const [
//                                                         Icon(Icons.photo),
//                                                         Text('Gallery'),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: width * .3,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     UpLoading(true);
//                                                   },
//                                                   child: Column(
//                                                     children:  [
//                                                       Icon(Icons.camera_alt),
//                                                       Text('Camera'),
//                                                       Padding(
//                                                         padding: const EdgeInsets.only(top: 30),
//                                                         child: Row(children: [
//                                                           Padding(
//                                                             padding: const EdgeInsets.only(right:18),
//                                                             child: Text('cancel'),
//                                                           ),
//                                                           Text('send')
//                                                         ],),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),