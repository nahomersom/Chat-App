import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:understand_firebase/Components/SharedButton.dart';
import 'package:understand_firebase/screens/chat_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                    email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email'
                )
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                 obscureText: true,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                   password = value;
                  //Do something with the user input.
                },
                decoration:kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'
                )
              ),
              const SizedBox(
                height: 24.0,
              ),
            SharedButton(buttonText: 'Login',
                onPressed: () async{
              setState(() {
                showSpinner = true;
              });
              try{
                final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                setState(() {
                  showSpinner = false;
                });
                  Navigator.pushNamed(context, ChatScreen.id);


              } catch(e){
                setState(() {
                  showSpinner = false;
                });
                if(kDebugMode){
                  print(e);
                }
              }

                },
                buttonColor: Colors.lightBlueAccent
            )
            ],
          ),
        ),
      ),
    );
  }
}
