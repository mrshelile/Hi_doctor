import 'package:flutter/material.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateAppointment.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateMadicalRecord.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class MedicalRecord extends StatefulWidget {
  MedicalRecord({required this.data});
  var data;
  @override
  State<MedicalRecord> createState() => _MedicalRecordState();
}

class _MedicalRecordState extends State<MedicalRecord> {
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    final date = DateTime.parse(widget.data['values']['createdAt']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue2,
        title: Text(
            "${date.day} - ${months[date.month - 1]} - ${date.year} ${date.hour}:${date.minute}"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient: ${widget.data['values']['patient']['data']['attributes']['full_name']}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Doctor: Dr. ${widget.data['values']['doctor']['data']['attributes']['full_name'] ?? 'None'}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Diagnosis: ${widget.data['values']['diaognosis'] ?? 'None'}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Treatment Plan: ${widget.data['values']['treatmentPlan'] ?? 'None'}",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Lab Results: ${widget.data['values']['labResults'] ?? 'None'}",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Medication Prescribed: ${widget.data['values']['medicationPrescribed'] ?? 'None'}",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Notes: ${widget.data['values']['notes'] ?? 'None'}",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      )),
    );
  }
}
