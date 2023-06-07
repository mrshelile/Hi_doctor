import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class MedicalRecordsLogic {
  String _medicalRecordsUrl = "api/medical-records";
  Future doctorCreateMedicalRecords(
      {required String diagnosis,
      required String treatmentPlan,
      required String prescription,
      required String lab,
      required String notes,
      required var ownId,
      required chosenUserId}) async {
    final Uri url = Uri.parse('$server$_medicalRecordsUrl');
    var body = {
      "data": {
        "doctor": ownId,
        "patient": chosenUserId,
        "diaognosis": diagnosis,
        "treatmentPlan": treatmentPlan,
        "medicationPrescribed": prescription,
        "labResults": lab,
        "notes": notes
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future doctorGetMedicalRecords(
      {required var user_id, required search}) async {
    List records = [];
    final Uri url = Uri.parse('$server$_medicalRecordsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get medical records while logged as doctor");

    for (var item in data) {
      if (item['attributes']['doctor'] != null) {
        // print(item['attributes']['doctor']['data']['id'].toString()+user_id.toString());
        if (item['attributes']['doctor']['data']['id'] == user_id) {
          records.add({"id": item['id'], "values": item['attributes']});
        }
      }
    }
    return records.where(
      (element) {
        if (search.isNotEmpty) {
          return element['values']['diaognosis']
              .toString()
              .toLowerCase()
              .startsWith(search.toLowerCase());
        }
        return true;
      },
    ).toList();
  }

  Future patientGetMedicalRecords(
      {required var user_id, required search}) async {
    List records = [];
    final Uri url = Uri.parse('$server$_medicalRecordsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get medical records while logged as patient");

    for (var item in data) {
      if (item['attributes']['patient'] != null) {
        // print(item['attributes']['patient']['data']['id'].toString() +
        //     user_id.toString());
        if (item['attributes']['patient']['data']['id'] == user_id) {
          records.add({"id": item['id'], "values": item['attributes']});
        }
      }
    }
    return records.where(
      (element) {
        if (search.isNotEmpty) {
          return element['values']['diaognosis']
              .toString()
              .toLowerCase()
              .startsWith(search.toLowerCase());
        }
        return true;
      },
    ).toList();
  }
}