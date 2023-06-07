import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateMadicalRecord.dart';
import 'package:hi_doctor/screens/Home/pages/components/MedicalRecord.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({super.key});

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  String name = "";
  String greeting = "Good Morning";
  final store = Get.find<Store>();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    if (store.user.doctor != null) {
      setState(() {
        name = "Dr. ${store.user.doctor['full_name']}";
      });
    }
    if (store.user.patient != null) {
      setState(() {
        name = "${store.user.patient['full_name']}";
      });
    }
    if (store.user.provider != null) {
      setState(() {
        name = "${store.user.provider['full_name']}";
      });
    }
    DateTime now = DateTime.now();

    if (now.hour < 12) {
      setState(() {
        greeting = "Good Morning";
      });
    }
    if (now.hour == 12) {
      setState(() {
        greeting = "GoodDay";
      });
    }
    if (now.hour > 1) {
      setState(() {
        greeting = "Good Evening";
      });
    }
    return GetBuilder(
        init: store,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.1,
                      child: SvgPicture.asset("assets/found1.svg"),
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.height * 0.05,
                      child: TextField(
                        controller: _searchController,
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
                    )
                  ],
                ),
              ),
              // SizedBox(),
              Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.03,
                      bottom: size.height * 0.01),
                  child: Text(
                    "Hi $name, ${greeting}!",
                    style: const TextStyle(
                        color: MyColors.blue2,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  )),
              SizedBox(
                width: size.width,
                height: size.height * 0.28,
                child: SvgPicture.asset("assets/dentist1.svg"),
              ),
              Container(
                padding: EdgeInsets.only(left: size.width * 0.7),
                width: size.width,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateMedicalRecord(),
                          ));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.create,
                          color: MyColors.blue1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Create",
                          style: TextStyle(color: MyColors.blue1),
                        )
                      ],
                    )),
              ),
              StreamBuilder(
                  stream: store.user.provider != null
                      ? Stream.empty()
                      : store.user.doctor != null
                          ? store
                              .getMedicalRecordsDoctor(
                                  id: store.user.doctor['id'])
                              .asStream()
                          : store
                              .getMedicalRecordsPatient(
                                  id: store.user.patient['id'])
                              .asStream(),
                  builder: (context, snapshots) {
                    if (!snapshots.hasData || snapshots.hasError) {
                      return const SizedBox();
                    }

                    return SizedBox(
                      height: size.height * 0.32,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0.5),
                        itemCount: snapshots.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MedicalRecord(
                                                  data: snapshots.data[index],
                                                )));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_circle_right,
                                    color: MyColors.blue1,
                                  )),
                              subtitle: Text(
                                  "Dr. ${snapshots.data[index]['values']['doctor']['data']['attributes']['full_name']} and patient ${snapshots.data[index]['values']['patient']['data']['attributes']['full_name']}"),
                              title: Text(
                                  snapshots.data[index]['values']['diaognosis'],
                                  style: const TextStyle(
                                    color: MyColors.blue2,
                                    fontWeight: FontWeight.w900,
                                  )));
                        },
                      ),
                    );
                  })
            ],
          );
        });
  }
}
