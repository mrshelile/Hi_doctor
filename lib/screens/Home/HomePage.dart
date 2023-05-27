import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 3 tabs.
    // _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: _tabController,
        pages: [
          // Tab 1
          Container(
            color: Colors.red,
            child: Center(
              child: Text('Tab 1'),
            ),
          ),
          // Tab 2
          Container(
            color: Colors.green,
            child: Center(
              child: Text('Tab 2'),
            ),
          ),
          // Tab 3
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('Tab 3'),
            ),
          ),
        ],
      ),
    );
  }
}
