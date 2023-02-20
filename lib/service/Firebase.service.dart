import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController {
  var name = "".obs;
  String url = "";
  var userList = [].obs;
  final _firestore = FirebaseFirestore.instance;
  var isExist = false.obs;
  var isLoading = false.obs;
  var failed = false.obs;
  var chatRoomId = "".obs;

  setChatRoomId(currentUser, chatUser) {
    if (name.value.compareTo(chatUser) > 0) {
      chatRoomId.value = name.value + chatUser;
    } else {
      chatRoomId.value = chatUser + name.value;
    }
  }

  createUser(context) async {
    isLoading.value = true;
    try {
      if (name != null) {
        for (var user in userList.value) {
          if (name = user['name']) {
            isExist.value = true;
          }
        }
        if (isExist.value == false) {
          await _firestore.collection("user").add({
            "name": name,
            "url": "",
            "dat": DateTime.now()
          }).whenComplete(() {
            Navigator.pushReplacementNamed(context, '/home');
            isLoading.value = false;
          });
        } else {
          isLoading.value = false;
          failed.value = true;
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  chatRoom(chat) async {
    try {
      await _firestore.collection("chatroom").doc(chatRoomId.value).update({
        'count': FieldValue.increment(1),
        'chat': FieldValue.arrayUnion(chat)
      });
    } catch (e) {
      debugPrint("error message");
    }
  }
}
