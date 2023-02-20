import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/colors.dart';
import '../model/userModel.dart';
import '../widgets/UserWidget.dart';

class HomePage extends StatefulWidget {
  User user;
   HomePage({super.key,required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        title: Text(
          "ChatApp",
          style: TextStyle(
              color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("name");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: firestore.collection("user").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return UserWidget(userInfo: snapshot.data!.docs[index],user:widget.user);
                  });
            } else {
              return Center(
                child: Text("No user"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          }
        },
      ),
    );
  }
}
