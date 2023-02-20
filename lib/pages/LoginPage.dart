import 'package:chatapp/service/Firebase.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextinput.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.message,
              size: 120,
              color: secondaryColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'ChatApp',
              style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
            CustomTextInput(
              hintText: 'Name',
              leading: Icons.person,
              obscure: false,
              keyboard: TextInputType.emailAddress,
              userTyped: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                text: 'Submit',
                accentColor: Colors.white,
                mainColor: secondaryColor,
                onpress: () async {
                  FirebaseService fs = FirebaseService();
                  fs.name.value = name!;
                  fs.createUser(context);
                }),
          ],
        ),
      ),
    );
  }
}
