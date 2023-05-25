import 'package:flutter/material.dart';
import 'package:hi_doctor/screens/Login/background.dart';
import 'package:hi_doctor/screens/Registration/Registration.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.blue2,
          child: Icon(Icons.send),
          onPressed: () {},
        ),
        body: Stack(
          children: [
            //stack overlaps widgets
            Background(),
            Container(
              width: size.width * 0.9,
              // height: size.height*0.3,
              // color: Colors.white,
              padding: EdgeInsets.only(
                  top: size.height * 0.3, left: size.width * 0.1),
              child: Form(
                  child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.cyan),
                        focusColor: MyColors.green0,
                        border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(45)),
                            borderSide: BorderSide(color: MyColors.blue1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.blue1),
                        ),
                        labelText: "National ID number"),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.cyan),
                        focusColor: MyColors.green0,
                        border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(45)),
                            borderSide: BorderSide(color:MyColors.blue1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.blue1),
                        ),
                        labelText: "Password"),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                  Center(
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(MyColors.blue1),
                          ),
                          // borderRadius: BorderRadius.all(Radius.circular(5)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterForm()));
                          },
                          child: const Text(
                            "Create Account here!",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              )),
            ),
          ],
        ));
  }
}
