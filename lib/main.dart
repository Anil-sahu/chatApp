import 'package:chatapp/constant/colors.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:chatapp/service/Firebase.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/HomePage.dart';
import 'pages/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  FirebaseService fs = FirebaseService();

  @override
  Widget build(BuildContext context) {
    print(fs.name);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatApp',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
        ),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: secondaryColor,
              systemNavigationBarDividerColor: secondaryColor,
              systemNavigationBarColor: secondaryColor),
          child: Welcomepage(),
        ));
  }
}
