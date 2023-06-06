import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class MedicalRecordsLogic {
  String _medicalRecordsUrl = "api/medical-records";

  Future doctorGetMedicalRecords(
      {required var user_id, required search}) async {
    List records = [];
    final Uri url = Uri.parse('$server$_medicalRecordsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get medical records while logged as doctor");
    var idUser = jsonDecode(await getAuthUser(id: user_id))['id'];
    for (var item in data) {
      if (item['attributes']['doctor'] != null) {
        // print(item);
        if (idUser == user_id) {
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

  Future providerGetMedicalRecords({required search}) async {
    List records = [];
    final Uri url = Uri.parse('$server$_medicalRecordsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get medical records while logged as provider");
    for (var item in data) {
      if (item['attributes']['provider'] != null) {
        records.add({"id": item['id'], "values": item['attributes']});
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
    var idUser = jsonDecode(await getAuthUser(id: user_id))['id'];
    for (var item in data) {
      if (item['attributes']['doctor'] != null) {
        // print(item);
        if (idUser == user_id) {
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

  Future getAuthUser({required var id}) async {
    final Uri url = Uri.parse("${server}api/users/$id?populate=*");

    return (await http.get(url)).body;

    // return jsonDecode(res.body);
  }
}
