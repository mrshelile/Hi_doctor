import 'package:get/get.dart';
import 'package:hi_doctor/logic/appointment_logic.dart';
import 'package:hi_doctor/models/User.dart';

class Store extends GetxController {
  final user = User();
  final appoitment = AppointmentLogic();
  String searchForAppointment = "";
  Future getUserAppointments({required var id}) async {
    var res = await appoitment.patientGetAppointments(
        id: id, search: searchForAppointment);
    // update();
    // print(res);
    return res;
  }
}
