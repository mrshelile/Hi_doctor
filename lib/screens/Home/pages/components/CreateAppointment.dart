import 'package:flutter/material.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({super.key});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue1,
        title: Text("Create an Appointment"),
      ),
      body: const Center(
        child: Text("Create appointment"),
      ),
    );
  }
}
