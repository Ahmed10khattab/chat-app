import 'package:chat1/firebase.dart/firestore.dart';
import 'package:chat1/provider/CurrentUser.dart';
import 'package:flutter/material(1).dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Message extends StatelessWidget {
  Message(
      {Key? key,
      required this.name,
      required this.isme,
      required this.SignUpUser,
      required this.massge,
      this.image,
      required this.delete})
      : super(key: key);
  String name;
  String massge;
  final bool isme;
  String? image;
  bool SignUpUser;
  Function delete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isme || SignUpUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(137, 37, 37, 37),
                fontStyle: FontStyle.italic),
          ),
          GestureDetector(
            onTapUp: (details) {
              var dx = details.globalPosition.dx;
              double dy = details.globalPosition.dy;
              double dx2 = MediaQuery.of(context).size.width - dx;
              double dy2 = MediaQuery.of(context).size.height - dy;
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                  items: [
                    PopupMenuItem(
                        onTap: () {
                          delete();
                        },
                        child: const Text('delete'))
                  ]);
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.only(
                  topRight: isme || SignUpUser
                      ? const Radius.circular(0)
                      : const Radius.circular(15),
                  topLeft: isme || SignUpUser
                      ? const Radius.circular(15)
                      : const Radius.circular(0),
                  bottomRight: const Radius.circular(15),
                  bottomLeft: const Radius.circular(15)),
              color: isme || SignUpUser
                  ? const Color.fromARGB(255, 135, 140, 141)
                  : Colors.blueAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  massge,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
