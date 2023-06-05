import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  final store = Get.find<Store>();
  final _searchPatientController = TextEditingController();
  String search = "";
  @override
  void initState() {
    super.initState();

    // This code is safe to run because it is not inside the onChange callback.
    _searchPatientController.addListener(() {
      // Update the state of the app whenever the text field is changed.
      setState(() {
        search = _searchPatientController.text.trim();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;

    return Scaffold(
      body: GetBuilder(
          init: store,
          builder: (_) {
            return Wrap(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      child: SvgPicture.asset("assets/nurse1.svg"),
                    ),
                    Text(
                      "Hi ${store.user.doctor != null ? "Dr. " + store.user.doctor['full_name'] : store.user.provider != null ? store.user.provider['full_name'] : store.user.patient['full_name']}",
                      style: const TextStyle(
                          color: MyColors.blue1, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.07),
                  width: size.width * 0.9,
                  height: size.height * 0.05,
                  child: TextFormField(
                    controller: _searchPatientController,
                    decoration: const InputDecoration(
                        labelText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 33, 148, 168)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 96, 154, 221)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 38, 122, 133)),
                        )),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.675,
                  child: StreamBuilder(
                    stream: store.getAllPatients(search: search).asStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.hasError) {
                        return SizedBox();
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              subtitle: Text(
                                  snapshot.data[index]['values']['contacts']),
                              title: Text(
                                  " ${snapshot.data[index]['values']['full_name']}"),
                              leading: SizedBox(
                                width: size.width * 0.1,
                                child: SvgPicture.asset(
                                    "assets/profileAvatar1.svg"),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
