import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:understand_firebase/screens/registration_screen.dart';

import '../Components/SharedButton.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation backgroundColorAnimation;
  late Animation buttonBorderAnimation;
  @override
  void initState() {
    super.initState();
  controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,

  );
    backgroundColorAnimation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
  // animation = CurvedAnimation(parent: controller,curve: Curves.decelerate);
  buttonBorderAnimation = BorderRadiusTween(begin: BorderRadius.circular(10),end:  BorderRadius.circular(70)).animate(controller);
  controller.forward();
  // animation.addStatusListener((status) {
  //   if(status == AnimationStatus.completed){
  //     controller.reverse(from: 1.0);
  //
  //   }else if(status == AnimationStatus.dismissed){
  //     controller.forward();
  //   }
  // });
  controller.addListener(() {
    setState(() {

    });
  });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorAnimation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(

                    tag: 'logo',
                    child: SizedBox(
                      child: Image.asset('images/logo.png'),
                      // height: animation.value * 100,
                      height: 60.0,
                    ),
                  ),
                ),
              DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black
                  ),
               child: AnimatedTextKit(
                  animatedTexts:[
                    TypewriterAnimatedText('Flash Chat')
                  ]
                ),
              )


              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
             SharedButton(
              buttonText: 'Login',
              onPressed:() {
               Navigator.pushNamed(context, LoginScreen.id);},
               buttonColor: Colors.lightBlueAccent,
            ),
            SharedButton(
                buttonText: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonColor: Colors.blueAccent)
          ],
        ),
      ),
    );/**/
  }
}

