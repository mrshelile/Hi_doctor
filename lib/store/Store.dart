import 'package:get/get.dart';
import 'package:hi_doctor/logic/MedicalRecords_Logic.dart';
import 'package:hi_doctor/logic/Patients_logic.dart';
import 'package:hi_doctor/logic/appointment_logic.dart';
import 'package:hi_doctor/logic/doctors_logic.dart';
import 'package:hi_doctor/models/User.dart';

class Store extends GetxController {
  final user = User();
  final appoitment = AppointmentLogic();
  final doctors = DoctorsLogic();
  final patients = PatientsLogic();
  final medicalRecords = MedicalRecordsLogic();
  String searchForAppointment = "";
  String searchForMedicalRecord = "";
  // String searchForDoctor = "";
  // String searchForPatient = "";
  Future getPatientAppointments({required var id}) async {
    return await appoitment.patientGetAppointments(
        id: id, search: searchForAppointment);
  }

  Future getMedicalRecordsDoctor({required var id}) async {
    return await medicalRecords.doctorGetMedicalRecords(
        user_id: id, search: searchForMedicalRecord);
  }

  Future getMedicalRecordsPatient({required var id}) async {
    return await medicalRecords.patientGetMedicalRecords(
        user_id: id, search: searchForMedicalRecord);
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
