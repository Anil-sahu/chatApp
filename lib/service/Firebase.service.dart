import 'package:chatapp/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/userModel.dart';

class FirebaseService extends GetxController {
  var name;
  String url = "";
  var userList = [].obs;
  final _firestore = FirebaseFirestore.instance;
  var isExist = false.obs;
  var isLoading = false.obs;
  var failed = false.obs;

  @override
  onInit() async {
    _firestore
        .collection("user")
        .get()
        .then((value) => userList.value = value.docs);
    super.onInit();
  }

  createUser(context, User user) async {
    bool isuserExist = false;
    await _firestore.collection("user").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        if (user.name == value.docs[i]['name']) {
          isuserExist = true;
        }
      }
    });

    isLoading.value = true;
    try {
      if (isuserExist == false) {
        await _firestore.collection("user").add(user.toMap()).whenComplete(() {
          Get.to(() => HomePage(user: user));
          isLoading.value = false;
        });
      } else {
        isLoading.value = false;
        failed.value = true;
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  chatRoom(chat, chatRoomId) async {
    try {
      await _firestore.collection("chatroom").doc(chatRoomId).update({
        'count': FieldValue.increment(1),
        'chat': FieldValue.arrayUnion([chat])
      });
      print(chat);
    } catch (e) {
      print("error");
      debugPrint(e.toString());
    }
  }
}
