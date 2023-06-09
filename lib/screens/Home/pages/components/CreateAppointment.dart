import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  var selectedValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue2,
        title: const Text('Create Appointment'),
      ),
      floatingActionButton: Container(
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
                          print(items);
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
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                  // print('selectedValue: $selectedValue');
                                  // print('snapshots.data: ${snapshots.data}');
                                },
                                items:
                                    items.map<DropdownMenuItem<dynamic>>((e) {
                                  return DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                          " ${snapshots.data[e]['values']['full_name']}"));
                                }).toList(),
                                buttonStyleData: ButtonStyleData(
                                  height: size.height * 0.06,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                )),
                          );
                        }),
                    FloatingActionButton(
                      backgroundColor: MyColors.blue2,
                      child: const Icon(Icons.send),
                      onPressed: () {},
                    ),
                  ]);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Illustration of a doctor and patient
              Image.asset('assets/doctor_patient.png'),
              const SizedBox(height: 16.0),

              // Name input field
              TextField(
                  controller: _titleController,
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
              TextField(
                  controller: _symptomsController,
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
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1827, 1),
                    lastDate: DateTime(2050),
                  ).then((date) {
                    setState(() {
                      _dateController.text = date!.toIso8601String();
                    });
                  });
                },
                // enabled: true,
                readOnly: true,
                // keyboardType: TextInputType.datetime,
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
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 12, minute: 1),
                  ).then((time) {
                    setState(() {
                      _timeController.text = time!.format(context);
                    });
                  });
                },
                // enabled: true,
                readOnly: true,
                // keyboardType: TextInputType.datetime,
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
                height: size.height*0.1,
              ),

              // Submit button
            ],
          ),
        ),
      ),
    );
  }
}
