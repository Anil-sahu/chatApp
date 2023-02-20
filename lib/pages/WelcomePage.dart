import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../constant/colors.dart';
import '../widgets/custombutton.dart';

class Welcomepage extends StatefulWidget {
  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage>
    with TickerProviderStateMixin {
  late AnimationController mainController;
  late Animation mainAnimation;
  @override
  void initState() {
    super.initState();
    mainController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    mainAnimation = ColorTween(begin: secondaryColor, end: Colors.grey[100])
        .animate(mainController);
    mainController.forward();
    mainController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainAnimation.value,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.chat,
                size: mainController.value * 100,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              CustomButton(
                text: 'Start',
                accentColor: Colors.white,
                mainColor: secondaryColor,
                onpress: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
