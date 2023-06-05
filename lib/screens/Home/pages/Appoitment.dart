import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/screens/Home/pages/components/CreateAppointment.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class Appoitments extends StatefulWidget {
  const Appoitments({super.key});

  @override
  State<Appoitments> createState() => _AppoitmentsState();
}

class _AppoitmentsState extends State<Appoitments> {
  final store = Get.find<Store>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    final _searchController = TextEditingController();
    return Scaffold(
      floatingActionButton: store.user.provider != null
          ? null
          : FloatingActionButton(
              backgroundColor: MyColors.blue2,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAppointment(),
                    ));
              },
              child: const Icon(Icons.create),
            ),
      body: GetBuilder(
          init: store,
          builder: (_) {
            return Wrap(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      child: SvgPicture.asset("assets/doctor2.svg"),
                    ),
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
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
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      store.searchForAppointment = value;
                      store.update();
                    },
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
                    stream: store.user.provider != null
                        ? store.getProviderAppointments().asStream()
                        : store.user.doctor != null
                            ? store.getDoctorAppointments(id: 2).asStream()
                            : store.getPatientAppointments(id: 2).asStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError || !snapshot.hasData) {
                        return const SizedBox();
                      }

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: ListTile(
                                          subtitle: Text(
                                              "Dr. ${snapshot.data[index]['values']['doctor']['data']['attributes']['full_name'].toString()}" +
                                                  " and ${snapshot.data[index]['values']['patient']['data']['attributes']['full_name'].toString()}"),
                                          title: Text(
                                              snapshot.data[index]['values']
                                                  ['title'],
                                              style: const TextStyle(
                                                color: MyColors.blue2,
                                                fontWeight: FontWeight.w900,
                                              ))),
                                      content: SizedBox(
                                        height: size.width * 0.3,
                                        child: ListView(
                                          children: [
                                            Text(snapshot.data[index]['values']
                                                    ['appointmentNotes']
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 191, 129, 71))),
                                          onPressed: () {
                                            // Do something with the user's name.
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Close"),
                                        ),
                                        if (store.user.doctor != null &&
                                            !snapshot.data[index]['values']
                                                ['doctor_confirm'])
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(MyColors.blue2)),
                                            onPressed: () {
                                              // Do something with the user's name.
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Confirm"),
                                          ),
                                        if (store.user.patient != null &&
                                            !snapshot.data[index]['values']
                                                ['patient_confirm'])
                                          ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(MyColors.blue2)),
                                            onPressed: () async {
                                              // Do something with the user's name.
                                              try {
                                                var response;
                                                if (store.user
                                                        .patient != // here patient confirms appointment
                                                    null) {
                                                  response = await store.user
                                                      .confirmAppointMentPatient(
                                                          id: snapshot
                                                                  .data[index]
                                                              ['id']);
                                                  store.update();
                                                }
                                                if (store.user
                                                        .doctor != // here doctor confirm appointment
                                                    null) {}

                                                if (response.statusCode ==
                                                    200) {
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                } else {
                                                  throw Exception("Failed");
                                                }
                                                //
                                              } catch (e) {
                                                debugPrint(e.toString());
                                              }
                                            },
                                            child: const Text("Confirm"),
                                          ),
                                      ]);
                                },
                              );
                            },
                            child: ListTile(
                              trailing: store.user.provider != null
                                  ? SizedBox()
                                  : snapshot.data[index]['values']
                                              ['patient_confirm'] &&
                                          snapshot.data[index]['values']
                                              ['doctor_confirm']
                                      ? const Icon(
                                          Icons.done,
                                          color: MyColors.green0,
                                        )
                                      : const Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.red,
                                        ),
                              subtitle:
                                  // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
                                  Text("${DateTime.parse(snapshot.data[index]['values']['createdAt']).year}-" +
                                      "${DateTime.parse(snapshot.data[index]['values']['createdAt']).month}-" +
                                      "${DateTime.parse(snapshot.data[index]['values']['createdAt']).day}  " +
                                      "${DateTime.parse(snapshot.data[index]['values']['createdAt']).hour}:" +
                                      "${DateTime.parse(snapshot.data[index]['values']['createdAt']).minute}"),
                              title: Text(
                                  "${snapshot.data[index]['values']['title']}"),
                              leading: SizedBox(
                                width: size.width * 0.13,
                                child: SvgPicture.asset("assets/security.svg"),
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
