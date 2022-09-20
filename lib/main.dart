import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:understand_firebase/screens/chat_screen.dart';
import 'package:understand_firebase/screens/login_screen.dart';
import 'package:understand_firebase/screens/registration_screen.dart';
import 'package:understand_firebase/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp( const FlashChat());
}

class FlashChat extends StatelessWidget {
   const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: const TextTheme(
      //     bodyText2: TextStyle(color: Colors.black54),
      //   ),
      // ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        ChatScreen.id:(context) => const ChatScreen(),
        RegistrationScreen.id :(context) => const RegistrationScreen(),
      },
    );
  }
}
