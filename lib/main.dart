import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Pet States',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override 
  void initState(){
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text ('Digital Pet States'),
       bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Happy"),
            Tab(text: "Hungry"),
            Tab(text: "Thirsty"),
            Tab(text: "Sleeping"),
            Tab(text: "Sad"),
              ],
            ), 
          ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          PetStateScreen(state: "Happy", description: "Your pet is feeling quited excited and energized!",bgColor: Colors.yellowAccent,textColor:Colors.black ),
          PetStateScreen(state: "Hungry", description: "Your pet is famished! It's time to feed it.",bgColor: Colors.orangeAccent,textColor:Colors.black ),
          PetStateScreen(state: "Thirsty", description: "Your pet is wandering for some water! Give it some.",bgColor: Colors.blueAccent,textColor:Colors.white),
          PetStateScreen(state: "Sleeping", description:"Your dog is taking some nice peaceful rest.",bgColor: Colors.pinkAccent,textColor:Colors.white),
          PetStateScreen(state: "Sad", description:"Your dog is very afraid and wary, cheer it up.",bgColor: Colors.grey,textColor:Colors.white ),
        ],
      ),
    );  
  }
}

class PetStateScreen extends StatelessWidget {
  final String state;
  final String description;
  final Color bgColor;
  final Color textColor;

  const PetStateScreen({super.key, required this.state, required this.description, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Center(
      child: Padding( 
        padding: const 
        EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state,
              style: TextStyle(
                fontSize:28,
                fontWeight:
          FontWeight.bold,
            color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                )
              ,textAlign:
              TextAlign.center,
            ),
          ],
        ),
      ),
      ),
    );
  }
}
// Tested and Implementation Successful
