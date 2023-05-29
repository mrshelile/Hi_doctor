import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_doctor/screens/Home/pages/components/MedicalRecord.dart';
import 'package:hi_doctor/theme/Mycolors.dart';

class MedicalRecords extends StatefulWidget {
  const MedicalRecords({super.key});

  @override
  State<MedicalRecords> createState() => _MedicalRecordsState();
}

class _MedicalRecordsState extends State<MedicalRecords> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).copyWith().size;
    final _searchController = TextEditingController();
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
              "Hi Malefetsane Shelile, Good Morning!",
              style: TextStyle(
                  color: MyColors.blue2,
                  fontWeight: FontWeight.w900,
                  fontSize: 20),
            )),
        SizedBox(
          width: size.width,
          height: size.height * 0.3,
          child: SvgPicture.asset("assets/dentist1.svg"),
        ),
        SizedBox(
          height: size.height * 0.38,
          child: ListView.builder(
            itemCount: 15,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicalRecord()));
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        color: MyColors.blue1,
                      )),
                  subtitle:
                      Text("Dr. Thao Nape and patient Malefetsane Shelile"),
                  title: Text("Diognosis",
                      style: TextStyle(
                        color: MyColors.blue2,
                        fontWeight: FontWeight.w900,
                      )));
            },
          ),
        )
      ],
    );
  }
}
