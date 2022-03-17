import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
    return GetBuilder(
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
                  stream: store.getUserAppointments(id: 2).asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData) {
                      return const SizedBox();
                    }
                    // print(snapshot.data);
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: store.user.provider != null
                              ? () {
                                  debugPrint(
                                      "provider_rep do not confirm appointnment");
                                }
                              : store.user.doctor != null &&
                                      snapshot.data[index]['doctor_confirm']
                                  ? () {
                                      debugPrint("doctor is already confirmed");
                                    }
                                  : store.user.patient != null &&
                                          snapshot.data[index]
                                              ['patient_confirm']
                                      ? () {
                                          debugPrint(
                                              "patient is aleady confirmed");
                                        }
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: ListTile(
                                                    subtitle: Text(
                                                        "Dr. ${snapshot.data[index]['doctor']['data']['attributes']['full_name'].toString()}" +
                                                            " and ${snapshot.data[index]['patient']['data']['attributes']['full_name'].toString()}"),
                                                    title: Text(
                                                        snapshot.data[index]
                                                            ['title'],
                                                        style: const TextStyle(
                                                          color: MyColors.blue2,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ))),
                                                content: Text(snapshot
                                                    .data[index]
                                                        ['appointmentNotes']
                                                    .toString()),
                                                actions: [
                                                  ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                    Color>(
                                                                Color.fromARGB(
                                                                    255,
                                                                    191,
                                                                    129,
                                                                    71))),
                                                    onPressed: () {
                                                      // Do something with the user's name.
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Close"),
                                                  ),
                                                  ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                    Color>(
                                                                MyColors
                                                                    .blue2)),
                                                    onPressed: () {
                                                      // Do something with the user's name.
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text("Confirm"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                          child: ListTile(
                            trailing: store.user.provider != null
                                ? SizedBox()
                                : store.user.doctor != null &&
                                        snapshot.data[index]['doctor_confirm']
                                    ? const Icon(
                                        Icons.done,
                                        color: MyColors.green0,
                                      )
                                    : store.user.patient != null &&
                                            snapshot.data[index]
                                                ['patient_confirm']
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
                                Text("${DateTime.parse(snapshot.data[index]['createdAt']).year}-" +
                                    "${DateTime.parse(snapshot.data[index]['createdAt']).month}-" +
                                    "${DateTime.parse(snapshot.data[index]['createdAt']).day}  " +
                                    "${DateTime.parse(snapshot.data[index]['createdAt']).hour}:" +
                                    "${DateTime.parse(snapshot.data[index]['createdAt']).minute}"),
                            title: Text("${snapshot.data[index]['title']}"),
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
        });
  }
}
