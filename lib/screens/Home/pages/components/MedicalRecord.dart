import 'package:flutter/material.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateAppointment.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateMadicalRecord.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class MedicalRecord extends StatefulWidget {
  const MedicalRecord({super.key});

  @override
  State<MedicalRecord> createState() => _MedicalRecordState();
}

class _MedicalRecordState extends State<MedicalRecord> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.blue1,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateMedicalRecord(),
              ));
        },
        child: const Icon(
          Icons.create_sharp,
        ),
      ),
      appBar: AppBar(
        backgroundColor: MyColors.blue2,
        title: Text("01 May 2022 16:30"),
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
              "Patient: Malefetsane Shelile",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Doctor:Dr Hlongwe Ndlovu",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Diagnosis: Flue",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Treatment Plan: Malefetsane Shelile dskds sdsd sdjk hdskjh dfjvhf dvh d dklhvsdv jkldhsjd hvhsvjsjkhlsd vhjsdvh klsdh vjksd hk",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Lab Results: None",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Medication Prescribed: DPH",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Notes: Notes",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      )),
    );
  }
}
