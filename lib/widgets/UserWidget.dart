import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors.dart';
import '../pages/ChatRoom.dart';
import '../service/Firebase.service.dart';

class UserWidget extends StatefulWidget {
  var userInfo;

  UserWidget({super.key, required this.userInfo});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  FirebaseService fs = FirebaseService();
FirebaseFirestore firestore= FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {

       
        fs.setChatRoomId(fs.name, widget.userInfo['name']);
        await firestore
          .collection("chatroom")
          .doc(fs.chatRoomId.value).set({"count":0,
          "chat":[]});
        Get.to(
          () => ChatRoom(
            seconduser: widget.userInfo['name'],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(12),
        color: Colors.red[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 10, right: 30),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/128/219/219969.png"))),
                ),
                Text(
                  "${widget.userInfo['name']}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Icon(
              Icons.more_vert,
              color: secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
