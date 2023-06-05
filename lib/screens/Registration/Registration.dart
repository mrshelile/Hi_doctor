import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_doctor/models/User.dart';
import 'package:hi_doctor/screens/Login/LoginForm.dart';
import 'package:hi_doctor/screens/Registration/components/background.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? selectedValue;
  DateTime? selectedDate;
  final _fullNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _addressController = TextEditingController();
  bool _idNumberExist = false;
  bool _passwordsMatched = false;
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _user = User();
  var _userFound;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
        floatingActionButton: Container(
          padding: EdgeInsets.only(left: size.width * 0.07),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: const Text(
                      '   Choose',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.cyan,
                      ),
                    ),
                    items: ["Doctor", "Patient", "Provider"]
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                "  $item",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.cyan,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                        height: size.height * 0.06,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        )),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: MyColors.blue2,
                  child: const Icon(Icons.send),
                  onPressed: () async {
                    if (_passwordController.text ==
                        _rePasswordController.text) {
                      setState(() {
                        _passwordsMatched = true;
                      });

                      // throw Exception("Password do not match");
                    } else {
                      setState(() {
                        _passwordsMatched = false;
                      });
                    }
                    if (_formkey.currentState!.validate()) {
                      try {
                        if (!_passwordsMatched) {
                          throw Exception("Passwords do not match");
                        }
                        if (selectedValue != null || selectedValue!.isEmpty) {
                          if (selectedValue.toString().toLowerCase() ==
                              "patient") {
                            // registration for patient
                            if (selectedDate != null) {
                            } else {
                              throw Exception("Date of birth is required");
                            }
                          }
                          if (selectedValue.toString().toLowerCase() ==
                              "doctor") // registration for doctor
                          {
                            var data = await _user.registerDoctor(
                                user: _userFound,
                                specialty: _specialtyController.text.trim(),
                                full_name: _fullNameController.text.trim(),
                                id_number: _idNumberController.text.trim(),
                                contact: _contactController.text.trim(),
                                password: _passwordController.text.trim());
                            if (data != null) {
                              
                              //ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginForm(),
                                  ));
                            }
                          }
                          if (selectedValue.toString().toLowerCase() ==
                              "provider") //Registraion of Hopital care provider
                          {
                            var data = await _user.registerProvider(
                                user: _userFound,
                                full_name: _fullNameController.text.trim(),
                                id_number: _idNumberController.text.trim(),
                                contact: _contactController.text.trim(),
                                password: _passwordController.text);
                            if (data != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginForm(),
                                  ));
                            }
                          }
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    }
                  },
                ),
              ]),
        ),
        body: Stack(
          children: [
            //stack overlaps widgets
            Background(),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.9,
              padding: EdgeInsets.only(
                  top: size.height * 0.3, left: size.width * 0.1),
              child: Form(
                  key: _formkey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelStyle: TextStyle(color: MyColors.blue0),
                            focusColor: MyColors.green0,
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(45)),
                                borderSide: BorderSide(color: MyColors.blue1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue1)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.blue1),
                            ),
                            labelText: "Full Name"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      if (selectedValue.toString().toLowerCase() ==
                          "doctor") ...[
                        TextFormField(
                          validator: (value) {
                            if (selectedValue.toString().toLowerCase() ==
                                "doctor") {
                              if (value == null || value.isEmpty) {
                                return "Field is required";
                              }
                            }
                            return null;
                          },
                          controller: _specialtyController,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              labelStyle: TextStyle(color: MyColors.blue0),
                              focusColor: MyColors.blue0,
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(45)),
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0),
                              ),
                              labelText: "Specialty"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                      TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _idNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is Required";
                          }
                          if (!_idNumberExist &&
                              selectedValue.toString().toLowerCase() !=
                                  "patient") {
                            return "ID Number does not exist";
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          if (selectedValue.toString().toLowerCase() ==
                                  "provider" &&
                              _idNumberController.text.isNotEmpty) {
                            try {
                              var res = await _user.checkIsProvider(
                                  checker: _idNumberController.text.trim());
                              if (res != null) {
                                setState(() {
                                  _userFound = res;
                                  _idNumberExist = true;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                _idNumberExist = false;
                              });
                              debugPrint(e.toString());
                            }
                          }
                          if (selectedValue.toString().toLowerCase() ==
                                  "doctor" &&
                              _idNumberController.text.isNotEmpty) {
                            try {
                              var res = await _user.checkIsDoctor(
                                  checker: _idNumberController.text.trim());
                              if (res != null) {
                                setState(() {
                                  _userFound = res;
                                  _idNumberExist = true;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                _idNumberExist = false;
                              });
                              debugPrint(e.toString());
                            }
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelStyle: TextStyle(color: MyColors.blue0),
                            focusColor: MyColors.blue0,
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(45)),
                                borderSide: BorderSide(color: MyColors.blue0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.blue0),
                            ),
                            labelText: "National ID number"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.digitsOnly,
                        // ],
                        controller: _contactController,
                        // keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is Required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelStyle: TextStyle(
                              color: MyColors.blue0,
                            ),
                            focusColor: MyColors.blue0,
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(45)),
                                borderSide: BorderSide(color: MyColors.blue0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.blue0),
                            ),
                            labelText: "Contacts +  code"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      if (selectedValue.toString().toLowerCase() ==
                          "patient") ...[
                        TextFormField(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1827),
                              lastDate: DateTime(2050),
                            ).then((date) {
                              setState(() {
                                selectedDate = date;
                              });
                            });
                          },
                          // enabled: true,
                          readOnly: true,
                          // keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              labelStyle: TextStyle(
                                color: MyColors.blue0,
                              ),
                              focusColor: MyColors.blue0,
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(45)),
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0),
                              ),
                              labelText: "Date of birth"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          controller: _addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Field is Required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              labelStyle: TextStyle(
                                color: MyColors.blue0,
                              ),
                              focusColor: MyColors.blue0,
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(45)),
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.blue0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0),
                              ),
                              labelText: "Address"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is required";
                          }
                          if (!_passwordsMatched) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelStyle: TextStyle(
                              color: MyColors.blue0,
                            ),
                            focusColor: MyColors.blue0,
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(45)),
                                borderSide: BorderSide(color: MyColors.blue0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.blue0),
                            ),
                            labelText: "Password"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field is required";
                          }
                          if (!_passwordsMatched) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        controller: _rePasswordController,
                        obscureText: true,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelStyle: TextStyle(
                              color: MyColors.blue0,
                            ),
                            focusColor: MyColors.blue0,
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(45)),
                                borderSide: BorderSide(color: MyColors.blue0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyColors.blue0)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyColors.blue0),
                            ),
                            labelText: "Confirm Password"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                          child: TextButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          MyColors.blue0)),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginForm()));
                              },
                              child: const Text(
                                "Signin Here!",
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  )),
            ),
          ],
        ));
  }
}
