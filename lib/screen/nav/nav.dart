import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriheart/config/config.dart';
import 'package:nutriheart/screen/screen.dart';

class Nav extends StatefulWidget {
  static String routeName = '/nav';
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _currentIndex = 0;

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final pages = [
    HomeScreen(),
    foodItemsPage(),
    AddFoodScreen(),
    calculatorPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: DotNavigationBar(
        currentIndex: _currentIndex,
        onTap: changePage,
        dotIndicatorColor:
            _currentIndex == 2 ? Colors.transparent : AppColors.colorPrimary,
        borderRadius: 0,
        backgroundColor: Colors.white,
        enablePaddingAnimation: false,
        marginR: EdgeInsets.zero,
        paddingR: EdgeInsets.zero,
        items: [
          DotNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 20.sp,
              ),
              selectedColor: AppColors.colorPrimary,
              unselectedColor: AppColors.colorTint400),
          DotNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.searchengin,
                size: 20.sp,
              ),
              selectedColor: AppColors.colorPrimary,
              unselectedColor: AppColors.colorTint400),
          DotNavigationBarItem(
            icon: Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.colorPrimary,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 20.sp,
                ),
              ),
            ),
            selectedColor: Colors.white,
            unselectedColor: Colors.white,
          ),
          DotNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calculator,
                size: 20.sp,
              ),
              selectedColor: AppColors.colorPrimary,
              unselectedColor: AppColors.colorTint400),
          DotNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.user,
                size: 20.sp,
              ),
              selectedColor: AppColors.colorPrimary,
              unselectedColor: AppColors.colorTint400),
        ],
      ),
    );
  }
}
