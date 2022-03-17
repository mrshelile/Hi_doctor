import 'package:get/get.dart';
import 'package:hi_doctor/logic/appointment_logic.dart';
import 'package:hi_doctor/logic/doctors_logic.dart';
import 'package:hi_doctor/models/User.dart';

class Store extends GetxController {
  final user = User();
  final appoitment = AppointmentLogic();
  final doctors = DoctorsLogic();
  String searchForAppointment = "";
  String searchForDoctor = "";
  Future getPatientAppointments({required var id}) async {
    return await appoitment.patientGetAppointments(
        id: id, search: searchForAppointment);
  }

  Future getAllDoctors() async {
    return await doctors.getallDoctors(search: searchForDoctor);
  }
}
