import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../model/userModel.dart';

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  User user;

  MessageBubble(
      {super.key,
      required this.msgText,
      required this.msgSender,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: user.name == msgSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: const TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: user.name == msgSender
                  ? const Radius.circular(50)
                  : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: user.name == msgSender
                  ? const Radius.circular(0)
                  : const Radius.circular(50),
            ),
            color: user.name == msgSender ? secondaryColor : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  // color: user ? Colors.white : secondaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
