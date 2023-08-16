// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino(1).dart';
// import 'package:flutter/material(1).dart';

// import '../custom/meassge.dart';
// import '../firebase.dart/auth.dart';
// import '../firebase.dart/firestore.dart';

// class Ch extends StatefulWidget {
//   const Ch({Key? key}) : super(key: key);

//   @override
//   State<Ch> createState() => _ChState();
// }

// class _ChState extends State<Ch> {
//   GlobalKey<FormState> formstate = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     FirebaseFirestore store = FirebaseFirestore.instance;
//     Stream<QuerySnapshot> Data = store.collection('Message').snapshots();
//     String? message;
//     final  textclean = TextEditingController();
//      final  user2 = ModalRoute.of(context)!.settings.arguments ;
//      var currentuser = user2;

//     return Scaffold(
//       backgroundColor: Colors.amber,
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 148, 146, 146),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Auth.auth.SignOut();
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.logout_rounded))
//         ],
//         toolbarHeight: 80,
//         title: Row(
//           children: const [
//             Text('Chat'),
//             SizedBox(
//               width: 10,
//             ),
//             CircleAvatar(
//               radius: 25,
//               backgroundImage: AssetImage('lib/images/p1 (2).png'),
//               backgroundColor: Colors.black,
//             )
//           ],
//         ),
//       ),
//       body: Form(
//         key: formstate,
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: Data, // store.collection('Message').snapshots(),

//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return Center(child: Text('error'));
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: Text('loading...'));
//                     }
//                     var data = snapshot.data;
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: ListView.builder(
//                         itemCount: data!.size,
//                         itemBuilder: (context, index) {
//                           // if (currentuser ==
//                           //     '${data.docs[index]['user']}@yahoo.com') {}
//                           return Message(
//                               delete: () {
//                                 FireStore.firestore.delete(data.docs[index].id);
//                               },
//                                isme: currentuser ==
//                                    '${data.docs[index]['user']} ',
//                               name: '${data.docs[index]['user']}',
//                               massge: '${data.docs[index]['msg']}');
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return 'enter message';
//                           }
//                         },
//                         controller: textclean,
//                         onChanged: ((value) {
//                           message = value;
//                         }),
//                         keyboardType: TextInputType.text,
//                         decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color.fromARGB(255, 253, 239, 239),
//                             suffixIcon: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.camera_enhance)),
//                             hintText: 'write a message',
//                             errorBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.blue),
//                                 borderRadius: BorderRadius.circular(30)),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.blue),
//                                 borderRadius: BorderRadius.circular(30)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide:
//                                     const BorderSide(color: Colors.blue),
//                                 borderRadius: BorderRadius.circular(30)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: Colors.blue),
//                               borderRadius: BorderRadius.circular(30),
//                             )),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () async {
//                           var valid = formstate.currentState;
//                           if (valid!.validate()) {
//                             valid.save();

//                             textclean.clear();
//                             await store
//                                 .collection('Message')
//                                 .doc(Random().nextDouble().toString())
//                                 .set({
//                               'time': FieldValue.serverTimestamp(),
//                               'msg': message,
//                               'user':
//                                  user2
//                                 //  .replaceFirst('@yahoo.com', ''),
//                     });
//                           }
//                         },
//                         icon: const Icon(Icons.send))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
