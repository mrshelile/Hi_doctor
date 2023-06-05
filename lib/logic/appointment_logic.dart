import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class AppointmentLogic {
  // List appointments = [];
  String _appointmentUrl = "api/appoitments";
  Future providerGetAppointment({required String search}) async {
    List appointments = [];
    final Uri url = Uri.parse('$server$_appointmentUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get Appointments while logged as provider");
    for (var item in data) {
      appointments.add({"id": item['id'], "values": item['attributes']});
    }
    return appointments.where(
      (element) {
        if (search.isNotEmpty) {
          return element['values']['title']
              .toString()
              .toLowerCase()
              .startsWith(search.toLowerCase());
        }
        return true;
      },
    ).toList();
  }

  Future patientGetAppointments(
      {required var id, required String search}) async {
    List appointments = [];
    final Uri url = Uri.parse('$server$_appointmentUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get Appointments while logged as patient");

    for (var item in data) {
      if (item['attributes']['patient'] != null) {
        if (item['attributes']['patient']['data']['id'] == id) {
          appointments.add({"id": item['id'], "values": item['attributes']});
        }
      }
    }
    return appointments.where(
      (element) {
        if (search.isNotEmpty) {
          return element['values']['title']
              .toString()
              .toLowerCase()
              .startsWith(search.toLowerCase());
        }
        return true;
      },
    ).toList();
  }

  Future doctorGetAppointments(
      {required var id, required String search}) async {
    List appointments = [];
    final Uri url = Uri.parse('$server$_appointmentUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get Appointments while logged as doctor");

    for (var item in data) {
      if (item['attributes']['doctor'] != null) {
        if (item['attributes']['doctor']['data']['id'] == id) {
          appointments.add({"id": item['id'], "values": item['attributes']});
        }
      }
    }
    return appointments.where(
      (element) {
        if (search.isNotEmpty) {
          return element['values']['title']
              .toString()
              .toLowerCase()
              .startsWith(search.toLowerCase());
        }
        return true;
      },
    ).toList();
  }
}
