import 'dart:convert';

import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class PatientsLogic {
  String _patientsUrl = "api/patients";
  Future getallPatients({required String search}) async {
    List patients = [];
    final Uri url = Uri.parse('$server$_patientsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    for (var item in data) {
      patients.add({"id": item['id'], "values": item['attributes']});
    }
    patients = patients.where((element) {
      if (search.isNotEmpty) {
        return element['values']['full_name']
            .toString()
            .toLowerCase()
            .startsWith(search.toLowerCase());
      }
      return true;
    }).toList();
    return patients;
  }
}
