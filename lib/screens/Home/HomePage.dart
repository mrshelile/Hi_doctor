import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor/screens/Home/pages/Appoitment.dart';
import 'package:hi_doctor/screens/Home/pages/Doctors.dart';
import 'package:hi_doctor/screens/Home/pages/MainScreen.dart';
import 'package:hi_doctor/screens/Home/pages/MedicalRecords.dart';
import 'package:hi_doctor/screens/Home/pages/Patients.dart';
import 'package:hi_doctor/store/Store.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Get.find<Store>();
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      // MainScreen(),
      const Appoitments(),
      if (store.user.provider == null) const MedicalRecords(),
      if (store.user.doctor == null) const Doctors(),
      if (store.user.patient == null) const Patients()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.healing_outlined),
        title: ("Appointments"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      if (store.user.provider == null)
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.medical_information),
          title: ("Medical Records"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      if (store.user.doctor == null)
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.people),
          title: ("Doctors"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      if (store.user.patient == null)
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.assist_walker_rounded),
          title: ("Patients"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GetBuilder(
            init: store,
            builder: (_) {
              return PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white, // Default is Colors.white.
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset:
                    true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows:
                    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle
                    .style1, // Choose the nav bar style with this property.
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
