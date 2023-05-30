import 'dart:convert';

import 'package:hi_doctor/constants/boot.dart';
import 'package:http/http.dart' as http;

class User {
  String? username;
  var id_number;
  var contacts;
  var patient;
  var doctor;
  var fullNames;
  var provider;
  DateTime? DOB;
  var id;
  String address = "";
  String jwt = "";
  String token = "";
  final String _login = "api/auth/local";
  final String _register = "api//api/auth/local/register";
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

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      this.jwt = data['jwt'];
      this.fullNames = data['user']['full_name'];
      this.id_number = data['user']['national_id_number'];
      this.username = data['user']['username'];
      this.id = data['user']['id'];
      // print(data);
      return data;
    } else if (response.statusCode == 405) {
      // print(response.body);
      throw Exception('Method Not Allowed');
    } else if (response.statusCode == 400) {
      throw Exception("Invalid logins");
    } else {
      // print(response.body);

      throw Exception('Failed to login');
    }
  }

  Future sendSms(
      {required String subject,
      required String message,
      required String phone_number}) async {}
  Future registerPatient(
      {required String full_name,
      required String Id_number,
      required String contact,
      required DateTime DOB,
      required String address}) // patient registration Logic
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'identifier': username,
      // 'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future registerDoctor(
      {required String full_name,
      required String specialty,
      required String Id_number,
      required String contact,
      required String token,
      required String password,
      required String rePassword}) // Doctor registration Logic
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'identifier': username,
      // 'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future registerProvider(
      {required String full_name,
      required String Id_number,
      required String contact,
      required String token,
      required String password,
      required String rePassword}) // Hospital registration Logic
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'identifier': username,
      // 'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
        await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future checkIsDoctor(
      {required String
          token}) //Check whether the provided token is available in the hospital and belongs to doctor
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'identifier': username,
      // 'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future
      checkIsProvider() //Check whether the provided token is available in the hospital and belongs to Hospital Representative
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'identifier': username,
      // 'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}
