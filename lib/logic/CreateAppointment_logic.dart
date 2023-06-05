import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_doctor/constants/boot.dart';
import 'package:hi_doctor/screens/Home/pages/Doctors.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CreateAppointmentLogic {
  String _appointmentUrl = "api/appoitments";

  Future patientCreateAppointment(
      {required var ownId,
      required String title,
      required String reason,
      required DateTime dateForAppointment,
      required TimeOfDay timeForAppointment,
      required var chosenUserId}) async {
    DateTime date = dateForAppointment.add(Duration(
        hours: timeForAppointment.hour, minutes: timeForAppointment.minute));

    // print(date);
    var uuid = Uuid();
    final Uri url = Uri.parse('$server$_appointmentUrl');
    var body = {
      "data": {
        "universal": uuid.v4(),
        "patient": ownId,
        "doctor": chosenUserId,
        "appointmentDate": date.toIso8601String(),
        "appointmentNotes": reason,
        "title": title,
        "patient_confirm": true,
        "doctor_confirm": false
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future doctorCreateAppointment(
      {required var ownId,
      required String title,
      required String reason,
      required DateTime dateForAppointment,
      required TimeOfDay timeForAppointment,
      required var chosenUserId}) async {
    DateTime date = dateForAppointment.add(Duration(
        hours: timeForAppointment.hour, minutes: timeForAppointment.minute));

    // print(date);
    var uuid = Uuid();
    final Uri url = Uri.parse('$server$_appointmentUrl');
    var body = {
      "data": {
        "universal": uuid.v4(),
        "doctor": ownId,
        "patient": chosenUserId,
        "appointmentDate": date.toIso8601String(),
        "appointmentNotes": reason,
        "title": title,
        "patient_confirm": false,
        "doctor_confirm": true
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await http.post(url, body: jsonEncode(body), headers: headers);
  }
}
