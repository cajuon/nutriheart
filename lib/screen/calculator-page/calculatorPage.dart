import 'package:flutter/material.dart';
import 'bmiTab.dart';
import 'calorieTab.dart';

// void main() {
//   runApp(const MyApp());
// }

class calculatorPage extends StatefulWidget {
  static String routeName = '/calculator';
  const calculatorPage({super.key});

  @override
  State<calculatorPage> createState() => _calculatorPageState();
}

class _calculatorPageState extends State<calculatorPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI and Calorie Calculator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
          // Fix 'bottom overflowed by pixels' error
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Nutriheart'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 24.0),
                      child: TabBar(
                          isScrollable: true,
                          controller: tabController,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.65),
                          ),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'BMI'),
                            Tab(text: 'Calorie Intake'),
                          ])),
                  Container(
                    width: 350,
                    height: 500,
                    child: TabBarView(
                        controller: tabController,
                        children: const <Widget>[
                          BMI(),
                          Calorie(),
                        ]),
                  ),
                ],
              ),
            ),
          )

          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ),
          ),
    );
  }
}
