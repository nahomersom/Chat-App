import 'package:flutter/material.dart';
class SharedButton extends StatelessWidget {
  final String  buttonText;
  final void Function()? onPressed;
  final Color buttonColor;
  const SharedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child:  Text(
              buttonText,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
