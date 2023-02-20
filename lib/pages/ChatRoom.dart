import 'package:chatapp/service/Firebase.service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant/colors.dart';

import '../model/userModel.dart';
import '../widgets/messageBubble.dart';

final _firestore = FirebaseFirestore.instance;
String username = 'User';

String? messageText;
// FirebaseUser loggedInUser;

class ChatRoom extends StatefulWidget {
  String seconduser = "";
  User user;
  String chatroomId;
  ChatRoom(
      {super.key,
      required this.seconduser,
      required this.user,
      required this.chatroomId});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final chatMsgTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  FirebaseService fs = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size(25, 10),
          child: Container(
            decoration: const BoxDecoration(
                // color: Colors.blue,

                // borderRadius: BorderRadius.circular(20)
                ),
            constraints: const BoxConstraints.expand(height: 1),
          ),
        ),
        backgroundColor: secondaryColor,
        title: Row(
          children: <Widget>[
            Text(
              'ChatApp',
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 20, color: primaryColor),
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            child: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatStream(
            chatRoomId: widget.chatroomId,
            user: widget.user,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: const CircleBorder(),
                    color: secondaryColor,
                    onPressed: () {
                      fs.chatRoom({
                        'sender': widget.user.name,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                      }, widget.chatroomId);

                      chatMsgTextController.clear();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatStream extends StatefulWidget {
  String chatRoomId;
  User user;
  ChatStream({super.key, required this.chatRoomId, required this.user});

  @override
  State<ChatStream> createState() => _ChatStreamState();
}

class _ChatStreamState extends State<ChatStream> {
  FirebaseService fs = FirebaseService();

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          firestore.collection("chatroom").doc(widget.chatRoomId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!['chat'];
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final msgText = message['text'];
            final msgSender = message['sender'];

            final msgBubble = MessageBubble(
              msgText: msgText,
              msgSender: msgSender,
              user: widget.user,
            );
            messageWidgets.add(msgBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return const Center(
            child:
                CircularProgressIndicator(backgroundColor: Colors.deepPurple),
          );
        }
      },
    );
  }
}
