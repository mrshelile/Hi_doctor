// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/logic/CreateAppointment_logic.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({super.key});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final store = Get.find<Store>();
  final _formKey = GlobalKey<FormState>();
  var selectedChooseUserIndex;
  var selectedUser;
  TimeOfDay? _selectedTime;
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  var selectedDate;
  bool isLoading = false;
  Widget loader = const Center(
    child: SpinKitWaveSpinner(
      color: Color.fromARGB(255, 15, 90, 124),
      size: 80.0,
      // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue2,
        title: const Text('Create Appointment'),
      ),
      floatingActionButton: isLoading
          ? loader
          : Container(
              padding: EdgeInsets.only(left: size.width * 0.07),
              child: GetBuilder(
                  init: store,
                  builder: (_) {
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder(
                              stream: store.user.patient != null
                                  ? store.getAllDoctors(search: "").asStream()
                                  : store.getAllPatients(search: "").asStream(),
                              builder: (context, snapshots) {
                                if (snapshots.hasError ||
                                    !snapshots.hasData ||
                                    snapshots.data == null) {
                                  return const SizedBox();
                                }
                                List<dynamic> items =
                                    snapshots.data.asMap().entries.map((e) {
                                  return e.key;
                                }).toList();

                                // var toKeyItems=
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                      hint: const Text(
                                        '  Choose',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                      value: selectedChooseUserIndex,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedUser = snapshots.data[value];
                                          selectedChooseUserIndex = value;
                                        });

                                        // print('selectedValue: $selectedValue');
                                        // print('snapshots.data: ${snapshots.data}');
                                      },
                                      items: items
                                          .map<DropdownMenuItem<dynamic>>((e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: SizedBox(
                                              width: size.width * 0.45,
                                              child: Text(
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  " ${snapshots.data[e]['values']['full_name']}"),
                                            ));
                                      }).toList(),
                                      buttonStyleData: ButtonStyleData(
                                        height: size.height * 0.06,
                                        width: size.width * 0.56,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      )),
                                );
                              }),
                          FloatingActionButton(
                            backgroundColor: MyColors.blue2,
                            child: const Icon(Icons.send),
                            onPressed: () async {
                              try {
                                // print(store.user.patient['id']);
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (store.user.patient != null) {
                                    if (selectedUser != null) {
                                      var res = await CreateAppointmentLogic()
                                          .patientCreateAppointment(
                                              ownId: store.user.patient['id'],
                                              title:
                                                  _titleController.text.trim(),
                                              reason: _symptomsController.text
                                                  .trim(),
                                              dateForAppointment:
                                                  selectedDate ??
                                                      DateTime.now(),
                                              timeForAppointment:
                                                  _selectedTime ??
                                                      TimeOfDay.now(),
                                              chosenUserId:
                                                  selectedUser['id'] ?? 1);

                                      if (res.statusCode == 200) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                        store.update();
                                      }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      throw Exception("User is not selected");
                                    }
                                  }
                                  if (store.user.doctor != null) {
                                    if (selectedUser != null) {
                                      var res = await CreateAppointmentLogic()
                                          .doctorCreateAppointment(
                                              ownId: store.user.doctor['id'],
                                              title:
                                                  _titleController.text.trim(),
                                              reason: _symptomsController.text
                                                  .trim(),
                                              dateForAppointment:
                                                  selectedDate ??
                                                      DateTime.now(),
                                              timeForAppointment:
                                                  _selectedTime ??
                                                      TimeOfDay.now(),
                                              chosenUserId:
                                                  selectedUser['id'] ?? 1);

                                      if (res.statusCode == 200) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(context);
                                        store.update();
                                      }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      throw Exception("User is not selected");
                                    }
                                  }
                                }
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                debugPrint(e.toString());
                              }
                            },
                          ),
                        ]);
                  }),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Illustration of a doctor and patient
                SizedBox(
                  width: size.width,
                  height: size.height * 0.3,
                  child: SvgPicture.asset("assets/doctor3.svg"),
                ),
                const SizedBox(height: 16.0),

                // Name input field
                TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
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
                        labelText: "Title")),
                const SizedBox(height: 16.0),

                // Symptoms input field
                TextFormField(
                    controller: _symptomsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field is required";
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
                        labelText: "Reason")),
                const SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "field is required";
                    }
                    return null;
                  },
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1827, 1),
                      lastDate: DateTime(2050),
                    ).then((date) {
                      setState(() {
                        if (date != null) {
                          _dateController.text =
                              "${date.day}  ${months[date.month]} ${date.year}";
                          selectedDate = date;
                        }
                      });
                    });
                  },
                  // enabled: true,
                  readOnly: true,

                  controller: _dateController,
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
                      labelText: "Date for Appointment"),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "field is required";
                    }
                    return null;
                  },
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 12, minute: 1),
                    ).then((time) {
                      setState(() {
                        _selectedTime = time;
                        _timeController.text = time!.format(context);
                      });
                    });
                  },
                  // enabled: true,
                  readOnly: true,

                  controller: _timeController,
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
                      labelText: "Time for appointment"),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),

                // Submit button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
