import 'package:flutter/material.dart';
import 'package:hi_doctor/screens/Login/background.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        //stack overlaps widgets
        Background()
      ],
    )));
  }
}
