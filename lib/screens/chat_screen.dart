import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String message;

  @override
  void initState() {
    super.initState();
    getCurrentUser();

  }

  void getCurrentUser(){
    try{
      final user = _auth.currentUser;
      loggedInUser = user!;
      if(kDebugMode){
        print(loggedInUser);
      }
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }

  }
  // void getMessage() async {
  //   QuerySnapshot messages = await _firestore.collection('messages').get();
  //
  //   for (var doc in messages.docs) {
  //     if (kDebugMode) {
  //       print(doc.data());
  //     }
  //   }
  // }
  void getStreamMessage()async{
    //below snapshot() method it's kind of subscribe method that listen to stream of data
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for (var message in snapshot.docs) {
            if (kDebugMode) {
              print(message.data());
            }
          }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pop(context);
                getStreamMessage();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                       'sender':loggedInUser.email,
                        'text':message
                      });
                      messageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context,snapshot){
          List<MessageBubble> messageWidgets = [];
          if(!snapshot.hasData){
            return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                )
            ) ;
          }
          final messages = snapshot.data?.docs.reversed;

          for(var message in messages!){
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = loggedInUser.email;

            final messageWidget = MessageBubble(
              messageSender: messageSender,
              messageText: messageText,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageWidget);



          }
          return Expanded(
            child: ListView(
               reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                children: messageWidgets

            ),
          );
        }
    );
  }
}


class MessageBubble extends StatelessWidget{
  final String messageSender;
  final String messageText;
  final bool isMe;
  const MessageBubble({Key? key,required this.messageSender,required this.messageText,required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [

        Text(
          messageSender,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12
          ),
        ),
       Material(
          borderRadius: isMe ? const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)
          ): const BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)
          ),
          elevation: 5.0,
          color: isMe ? Colors.lightBlueAccent :Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Text(messageText,style:  TextStyle(
                fontSize: 15.0,
                color: isMe ? Colors.white : Colors.black54
            ),),
          ),
        ),
      ]
      ),
    );
  }
}
