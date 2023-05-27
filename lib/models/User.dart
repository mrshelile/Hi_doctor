import 'dart:convert';

import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class User {
  var username;
  int? id_number;
  var contacts;
  var patient;
  var doctor;
  var fullNames;
  var provider;
  final String _login = "api/auth/local";
  Future login({required String username, required String password}) async {
    final Uri url = Uri.parse('$server$_login');
    final body = {
      'identifier': username,
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  
    final response = await http.post(
      url,
      body: jsonEncode(body),headers: headers
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 405) {
      // print(response.body);
      throw Exception('Method Not Allowed');
    } else if (response.statusCode == 400) {
      throw Exception("Invalid logins");
    } else {
      print(response.body);

      throw Exception('Failed to login');
    }
  }
}
