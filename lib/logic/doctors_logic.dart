import 'dart:convert';

import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class DoctorsLogic {
  String _doctorsUrl = "api/doctors";
  Future getallDoctors({required String search}) async {
    List doctors = [];
    final Uri url = Uri.parse('$server$_doctorsUrl?populate=*');
    var response = await http.get(url);
    List data = jsonDecode(response.body)['data'];
    for (var item in data) {
      doctors.add({"id": item['id'], "values": item['attributes']});
    }
    doctors = doctors.where((element) {
      if (search.isNotEmpty) {
        return element['values']['specialty']
                .toString()
                .toLowerCase()
                .startsWith(search.toLowerCase()) ||
            element['values']['full_name']
                .toString()
                .toLowerCase()
                .startsWith(search.toLowerCase());
      }
      return true;
    }).toList();
    return doctors;
  }
}
