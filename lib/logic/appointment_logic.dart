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

  Future getAuthUser({required var id}) async {
    final Uri url = Uri.parse("${server}api/users/$id?populate=*");

    return (await http.get(url)).body;

    // return jsonDecode(res.body);
  }

  Future patientGetAppointments(
      {required var id, required String search}) async {
    List appointments = [];
    final Uri url = Uri.parse('$server$_appointmentUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    debugPrint("Get Appointments while logged as patient");
    var idUser = jsonDecode(await getAuthUser(id: id))['id'];
    for (var item in data) {
      if (item['attributes']['patient'] != null) {
        // print(item);
        if (idUser == id) {
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
    var idUser = jsonDecode(await getAuthUser(id: id))['id'];
    for (var item in data) {
      if (item['attributes']['doctor'] != null) {
        if (idUser == id) {
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
