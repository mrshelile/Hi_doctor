import 'package:get/get.dart';
import 'package:hi_doctor/logic/Patients_logic.dart';
import 'package:hi_doctor/logic/appointment_logic.dart';
import 'package:hi_doctor/logic/doctors_logic.dart';
import 'package:hi_doctor/models/User.dart';

class Store extends GetxController {
  final user = User();
  final appoitment = AppointmentLogic();
  final doctors = DoctorsLogic();
  final patients = PatientsLogic();
  String searchForAppointment = "";
  // String searchForDoctor = "";
  // String searchForPatient = "";
  Future getPatientAppointments({required var id}) async {
    return await appoitment.patientGetAppointments(
        id: id, search: searchForAppointment);
  }

  Future getProviderAppointments() async {
    return await appoitment.providerGetAppointment(
        search: searchForAppointment);
  }

  Future getDoctorAppointments({required var id}) async {
    return await appoitment.doctorGetAppointments(
        id: id, search: searchForAppointment);
  }

  Future getAllDoctors({required String search}) async {
    // print(searchForDoctor);
    return await doctors.getallDoctors(search: search);
  }

  Future getAllPatients({required search}) async {
    // print(searchForPatient);
    return await patients.getallPatients(search: search);
  }
}
