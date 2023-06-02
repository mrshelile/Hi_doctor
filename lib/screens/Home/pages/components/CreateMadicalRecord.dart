import 'package:flutter/material.dart';

class CreateMedicalRecord extends StatefulWidget {
  const CreateMedicalRecord({super.key});

  @override
  State<CreateMedicalRecord> createState() => _CreateMedicalRecordState();
}

class _CreateMedicalRecordState extends State<CreateMedicalRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Medical Record"),
      ),
    );
  }
}
