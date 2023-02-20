import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/colors.dart';
import '../model/userModel.dart';
import '../pages/ChatRoom.dart';
import '../service/Firebase.service.dart';

class UserWidget extends StatefulWidget {
  var userInfo;
  User user;
  UserWidget({super.key, required this.userInfo, required this.user});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  FirebaseService fs = FirebaseService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var chatRoomId;
        setState(() {
          if (widget.user.name.toString().compareTo(widget.userInfo['name']) >
              0) {
            chatRoomId = (widget.user.name! + widget.userInfo['name']);
          } else {
            chatRoomId = widget.userInfo['name'] + widget.user.name;
          }
        });
        await firestore.collection("chatroom").get().then((value) async {
          var isChatRoomExist = false;
          for (var i = 0; i < value.docs.length; i++) {
            if (value.docs[i].id == chatRoomId.toString().replaceAll(" ", "")) {
              isChatRoomExist = true;
            }
          }

          if (isChatRoomExist == false) {
            await firestore
                .collection("chatroom")
                .doc(chatRoomId.toString().replaceAll(" ", ""))
                .set({"count": 0, "chat": []});
          }
        });

        Get.to(
          () => ChatRoom(
              seconduser: widget.userInfo['name'],
              user: widget.user,
              chatroomId: chatRoomId.toString().replaceAll(" ", "")),
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
