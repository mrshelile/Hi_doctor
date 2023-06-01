import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_doctor/models/User.dart';
import 'package:hi_doctor/screens/Home/HomePage.dart';
import 'package:hi_doctor/screens/Login/background.dart';
import 'package:hi_doctor/screens/Registration/Registration.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _error = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    final store = Get.find<Store>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.blue2,
          child: Icon(Icons.send),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomePage()));

              try {
                print("object");
                var res = await store.user
                    .login(
                        username: _usernameController.text.trim(),
                        password: _passwordController.text.trim())
                    .timeout(Duration(seconds: 20), onTimeout: () {
                  throw Exception("server might be available");
                });
                if (res['jwt'] != null) {
                  setState(() {
                    _error = '';
                  });
                  store.update();
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
                // print(res);
              } catch (e) {
                setState(() {
                  _error = e.toString();
                });
              }
            }
          },
        ),
        body: GetBuilder(
            init: store,
            builder: (_) {
              return Stack(
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
                        key: _formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: _usernameController,
                              validator: Validators.compose([
                                Validators.required('ID number is required'),

                                // Validators.email('wrong email format'),
                              ]),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.cyan),
                                  focusColor: MyColors.green0,
                                  border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.all(Radius.circular(45)),
                                      borderSide:
                                          BorderSide(color: MyColors.blue1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.blue1),
                                  ),
                                  labelText: "National ID number"),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: Validators.compose([
                                Validators.required('Password is required'),
                                // Validators.email('wrong email format'),
                              ]),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.cyan),
                                  focusColor: MyColors.green0,
                                  border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.all(Radius.circular(45)),
                                      borderSide:
                                          BorderSide(color: MyColors.blue1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColors.blue1),
                                  ),
                                  labelText: "Password"),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              _error,
                              style: const TextStyle(color: Colors.red),
                            ),
                            Center(
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              MyColors.blue1),
                                    ),
                                    // borderRadius: BorderRadius.all(Radius.circular(5)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterForm()));
                                    },
                                    child: const Text(
                                      "Create Account here!",
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        )),
                  ),
                ],
              );
            }));
  }
}
