import 'dart:convert';
import 'package:get/get.dart';
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
  final String _userUrl = "api/users";
  final String _providerUrl = "api/providers";
  final String _doctorUrl = "api/doctors";
  final String _patientUrl = "api/patients";
  final String _login = "api/auth/local";
  final String _register = "api/auth/local/register";
  final String _appointmentUrl = "api/appoitments";
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

      this.username = data['user']['username'];
      this.id = data['user']['id'];
      // print(data);
      var res = await http.get(Uri.parse('$server$_userUrl/$id?populate=*'));
      patient = jsonDecode(res.body)['patient'];
      doctor = jsonDecode(res.body)['doctor'];
      provider = jsonDecode(res.body)['provider_rep'];
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

  Future confirmAppointMentPatient({required var id}) async {
    final Uri url = Uri.parse('$server$_appointmentUrl/$id');
    final body = {
      "data": {
        'patient_confirm': true,
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return await http.put(url, body: jsonEncode(body), headers: headers);
  }

  Future confirmAppointMentDoctor({required var id}) async {
    final Uri url = Uri.parse('$server$_appointmentUrl/$id');
    final body = {
      "data": {
        'doctor_confirm': true,
      }
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return await http.put(url, body: jsonEncode(body), headers: headers);
  }

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

    return await http.post(url, body: jsonEncode(body), headers: headers);
  }

  Future registerDoctor(
      {required String full_name,
      required String id_number,
      required String contact,
      required var user,
      required String specialty,
      required String password}) // Hospital provider registration Logic
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'username': id_number,
      "email": "$id_number@email.com",
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (user != null) {
      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final body1 = {
          "data": {
            "contacts": contact,
            "user": data['user']['id'],
            "id_number": id_number,
            "specialty": specialty,
            "full_name": full_name
          }
        };
        var res = await http.put(Uri.parse("$server$_doctorUrl/${user['id']}"),
            body: jsonEncode(body1), headers: headers);

        if (res.statusCode == 200) {
          return jsonDecode(res.body);
        }

        throw Exception(
            "Unhandled error and user provider not updated or registered");
      } else {
        throw Exception("failed to register");
      }
    } else {
      throw Exception("User hospital provider not found");
    }
  }

  Future registerProvider(
      {required String full_name,
      required String id_number,
      required String contact,
      required var user,
      required String password}) // Hospital provider registration Logic
  async {
    final Uri url = Uri.parse('$server$_register');
    final body = {
      'username': id_number,
      "email": "$id_number@email.com",
      'password': password,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (user != null) {
      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final body1 = {
          "data": {
            "contacts": contact,
            "user": data['user']['id'],
            "id_number": id_number,
            "full_name": full_name
          }
        };
        var res = await http.put(
            Uri.parse("$server$_providerUrl/${user['id']}"),
            body: jsonEncode(body1),
            headers: headers);

        if (res.statusCode == 200) {
          return jsonDecode(res.body);
        }

        throw Exception(
            "Unhandled error and user provider not updated or registered");
      } else {
        throw Exception("failed to register");
      }
    } else {
      throw Exception("User hospital provider not found");
    }
  }

  Future checkIsDoctor(
      {required String
          checker}) //Check whether the provided token is available in the hospital and belongs to doctor
  async {
    final Uri url = Uri.parse('$server$_doctorUrl');
    // final body = {
    //   'identifier': username,
    //   // 'password': password,
    // };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var res = await http.get(url);

    if (res.statusCode.toInt() == 200) {
      var data = jsonDecode(res.body);

      for (var item in data['data']) {
        if (item['attributes']['id_number'].toString().toLowerCase() ==
            checker.toString().toLowerCase()) {
          return item;
        }
      }
      throw Exception("Hospital Provider with that ID does not exist");
    }
    throw Exception("Failed or No provider registered");
  }

  Future checkIsProvider({
    required String checker,
  }) //Check whether the provided token is available in the hospital and belongs to Hospital Representative
  async {
    final Uri url = Uri.parse('$server$_providerUrl');
    // final body = {
    //   'identifier': username,
    //   // 'password': password,
    // };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var res = await http.get(url);

    if (res.statusCode.toInt() == 200) {
      var data = jsonDecode(res.body);

      for (var item in data['data']) {
        if (item['attributes']['id_number'].toString().toLowerCase() ==
            checker.toString().toLowerCase()) {
          return item;
        }
      }
      throw Exception("Hospital Provider with that ID does not exist");
    }
    throw Exception("Failed or No provider registered");
  }
}
