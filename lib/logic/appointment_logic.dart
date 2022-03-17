import 'dart:convert';

import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class AppointmentLogic {
  // List appointments = [];
  String _appointmentUrl = "api/appoitments";
  Future patientGetAppointments({
    required var id,
  }) async {
   List appointments = [];
    final Uri url = Uri.parse('$server$_appointmentUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];

    for (var item in data) {
      if (item['attributes']['patient'] != null) {
        if (item['attributes']['patient']['data']['id'] == id) {
          appointments.add(item['attributes']);
        }
      }
    }

    return appointments;
  }
}
