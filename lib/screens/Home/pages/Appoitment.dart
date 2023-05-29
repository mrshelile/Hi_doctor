import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class Appoitments extends StatefulWidget {
  const Appoitments({super.key});

  @override
  State<Appoitments> createState() => _AppoitmentsState();
}

class _AppoitmentsState extends State<Appoitments> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    final _searchController = TextEditingController();
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
            const Text(
              "Hi Dr. Malefetsane Shelile",
              style:
                  TextStyle(color: MyColors.blue1, fontWeight: FontWeight.w700),
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
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 33, 148, 168)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 96, 154, 221)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 38, 122, 133)),
                )),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        SizedBox(
          height: size.height * 0.675,
          child: StreamBuilder(
            builder: (context, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 25,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const ListTile(
                                subtitle: Text(
                                    "Dr. Thao Nape and patient Malefetsane Shelile"),
                                title: Text("Teeth Removal",
                                    style: TextStyle(
                                      color: MyColors.blue2,
                                      fontWeight: FontWeight.w900,
                                    ))),
                            content: Text(
                                "dsdfdkfkjdh dfjk dfkdlf ddk ldkf f dkg   dk dfdfv f dv dfd dffvdfdfd fd f"),
                            actions: [
                              ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color.fromARGB(255, 191, 129, 71))),
                                onPressed: () {
                                  // Do something with the user's name.
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close"),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            MyColors.blue2)),
                                onPressed: () {
                                  // Do something with the user's name.
                                  Navigator.of(context).pop();
                                },
                                child: Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      trailing: Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red,
                      ),
                      subtitle: Text("02 July 2023 16:80"),
                      title: Text("Dr. Malefetsane Shelile"),
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
  }
}
