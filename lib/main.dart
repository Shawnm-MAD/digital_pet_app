import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

//Stateless widget since it extends to the initial build (root)
//Once we have initial then we can move on to a stateful widget

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //manages state for tab interface. each state will have something different (tab bar/view)
      home: DefaultTabController(
        length: 3,
        //this is the stateful widget, it holds the look of the tab
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    //event listener which will listen for updates and will update the tab index
    super.initState();
    _tabController = TabController(
      //number of tabs we have
      initialIndex: 0,
      length: 7,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  final TextEditingController cityname = TextEditingController();
  String cityName = "";
  String temperature = "";
  String weather = "";
  List<String> weatherstates = ["Sunny", "Cloudy", "Rainy"];
  List<Map<String, String>> weekly = [];

  void fetchWeather() {
    final random = Random();
    setState(() {
      cityName = cityname.text.trim();
      temperature = "${random.nextInt(16) + 15}°C";
      weather = weatherstates[random.nextInt(weatherstates.length)];
    });
  }

  void forecast() {
    final random = Random();
    setState(() {
      cityName = cityname.text.trim();
      weekly = List.generate(7, (index) {
        return {
          "day": "Day ${index + 1}",
          "temperature": "${random.nextInt(16) + 15}°C",
          "condition": weatherstates[random.nextInt(weatherstates.length)],
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
// For the ToDo task hint: consider defining the widget and name of the tabs here
    final tabs = [
      'Day 1',
      'Day 2',
      'Day 3',
      'Day 4',
      'Day 5',
      'Day 6',
      'Day 7'
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'The Weather Channel',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cityname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter city name:',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text("Fetch Weather"),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: forecast,
              child: Text("7 Day Forecast"),
            ),
            SizedBox(height: 32.0),
            Text("City: $cityName", style: TextStyle(fontSize: 18)),
            Text("Temperature: $temperature", style: TextStyle(fontSize: 18)),
            Text("Condition: $weather", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
