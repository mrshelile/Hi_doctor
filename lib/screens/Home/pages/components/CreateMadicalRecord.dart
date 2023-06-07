import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/logic/MedicalRecords_Logic.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class CreateMedicalRecord extends StatefulWidget {
  const CreateMedicalRecord({super.key});

  @override
  State<CreateMedicalRecord> createState() => _CreateMedicalRecordState();
}

class _CreateMedicalRecordState extends State<CreateMedicalRecord> {
  final TextEditingController _treatmentPlanController =
      TextEditingController();
  final TextEditingController _prescriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _labController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final store = Get.find<Store>();
  final _formKey = GlobalKey<FormState>();
  var selectedChooseUserIndex;
  var selectedUser;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue2,
        title: const Text('Create Medical Record'),
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
                                items:
                                    items.map<DropdownMenuItem<dynamic>>((e) {
                                  return DropdownMenuItem(
                                      value: e,
                                      child: SizedBox(
                                        width: size.width * 0.45,
                                        child: Text(
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            " ${snapshots.data[e]['values']['full_name']}"),
                                      ));
                                }).toList(),
                                buttonStyleData: ButtonStyleData(
                                  height: size.height * 0.06,
                                  width: size.width * 0.56,
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
                      onPressed: () async {
                        try {
                          // print(store.user.patient['id']);
                          if (_formKey.currentState!.validate()) {
                            if (store.user.doctor != null) {
                              if (selectedUser != null) {
                                var res = await MedicalRecordsLogic()
                                    .doctorCreateMedicalRecords(
                                        ownId: store.user.doctor['id'],
                                        chosenUserId: selectedUser['id'] ?? 1,
                                        diagnosis:
                                            _diagnosisController.text.trim(),
                                        treatmentPlan: _treatmentPlanController
                                            .text
                                            .trim(),
                                        prescription:
                                            _prescriptionController.text.trim(),
                                        lab: _labController.text,
                                        notes: _notesController.text.trim());

                                if (res.statusCode == 200) {
                                  Navigator.pop(context);
                                  store.update();
                                }
                              } else {
                                throw Exception("User is not selected");
                              }
                            }
                          }
                        } catch (e) {
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
                  child: SvgPicture.asset("assets/Hospital-patient.svg"),
                ),
                const SizedBox(height: 16.0),

                // Name input field
                TextFormField(
                    controller: _diagnosisController,
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
                        labelText: "Diagnosis**")),
                const SizedBox(height: 16.0),

                // Diagnosis input field
                TextFormField(
                    controller: _treatmentPlanController,
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
                        labelText: "Treatment Plan**")),

                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _prescriptionController,
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
                        labelText: "Medication Prescribed**")),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _labController,
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
                        labelText: "Laboratory Results")),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _notesController,
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
                        labelText: "Notes")),
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
