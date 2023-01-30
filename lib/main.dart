import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:nutriheart/screen/screen.dart';

import 'config/routes/routes.dart';

// import 'calculatorPage/calculatorPage.dart';
// import 'profilePage/profilePage.dart';
// import 'foodItemsPage/foodItemsPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.purple,
                bottomSheetTheme:
                    BottomSheetThemeData(backgroundColor: Colors.white)),
            debugShowCheckedModeBanner: false,
            initialRoute: verifyAuth.routeName,
            routes: routes,
          );
        });

    // MaterialApp(
    //   title: 'NutriHeart',
    //   theme: ThemeData(
    //       primarySwatch: Colors.purple,
    //       inputDecorationTheme: InputDecorationTheme(
    //           border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(8),
    //       )),
    //       outlinedButtonTheme: OutlinedButtonThemeData(
    //           style: OutlinedButton.styleFrom(
    //               minimumSize: Size.fromHeight(50),
    //               textStyle: TextStyle(fontSize: 20),
    //               backgroundColor: Colors.blue,
    //               primary: Colors.white))),
    //   home: const MainPage(),
    // );
  }
}
