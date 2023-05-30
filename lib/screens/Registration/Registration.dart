import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    final _fullNameController = TextEditingController();
    final _contactController = TextEditingController();
    final _idNumberController = TextEditingController();
    final _addressController = TextEditingController();
    final _tokenController = TextEditingController();
    final _passwordController = TextEditingController();
    final _rePasswordController = TextEditingController();
    final _specialtyController = TextEditingController();
    final _formkey = GlobalKey<FormState>();
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
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      try {
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
                          {}
                          if (selectedValue.toString().toLowerCase() ==
                              "provider") //Registraion of Hopital care provider
                          {}
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
                          return null;
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _contactController,
                        keyboardType: TextInputType.number,
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
                      ] else
                        // else
                        ...[
                        TextFormField(
                          validator: (value) {
                            if (selectedValue.toString().toLowerCase() !=
                                "patient") {
                              if (value == null || value.isEmpty) {
                                return "Field is Required";
                              }
                            }
                            return null;
                          },
                          controller: _tokenController,
                          obscureText: true,
                          // keyboardType: TextInputType.number,
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
                              labelText: "token"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (selectedValue.toString().toLowerCase() !=
                                "patient") {
                              if (value == null || value.isEmpty) {
                                return "Field is required";
                              }
                            }
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          // keyboardType: TextInputType.number,
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
                              labelText: "Password"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (selectedValue.toString().toLowerCase() !=
                                "patient") {
                              if (value == null || value.isEmpty) {
                                return "Field is required";
                              }
                            }
                            return null;
                          },
                          controller: _rePasswordController,
                          obscureText: true,
                          // keyboardType: TextInputType.number,
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
                              labelText: "Confirm Password"),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        )
                      ],
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
