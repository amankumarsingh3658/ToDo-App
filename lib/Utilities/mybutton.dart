import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  String text;
  VoidCallback onPress;
  Mybutton({super.key,required this.text,required this.onPress});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: onPress,child: Text(text),);
  }
}