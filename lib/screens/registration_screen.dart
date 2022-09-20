import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:understand_firebase/Components/SharedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:understand_firebase/screens/chat_screen.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
 static  const  String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late  String email;
  late  String password;
  bool showSpinner = false;
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
                  //Do something with the user input.
                  email = value;
                },
                decoration:kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Email'
                )
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: const TextStyle(

                ),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration:kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'
                )
              ),
              const SizedBox(
                height: 24.0,
              ),
             SharedButton(buttonText: 'Register',
                 onPressed: ()async{
               if(kDebugMode){
                 print(password);
               }
                try{
                 setState((){
                   showSpinner = true;
                 });

                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password)
                  .then((value)=>{
                  setState((){
                  showSpinner = false;
                  }),

                  });

                   Navigator.pushNamed(context, ChatScreen.id);

                }catch(e){
                  setState((){
                    showSpinner = false;
                  });/**/
                  if(kDebugMode){
                    print(e);
                  }

                }
                },
                 buttonColor: Colors.blueAccent
             )
            ],
          ),
        ),
      ),
    );
  }
}
