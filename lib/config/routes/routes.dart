import 'package:flutter/widgets.dart';
import 'package:nutriheart/screen/screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  Nav.routeName: (context) => Nav(),
  DailySummaryDetailScreen.routeName: (context) => DailySummaryDetailScreen(),
  AddFoodScreen.routeName: (context) => AddFoodScreen(),
  calculatorPage.routeName: (context) => calculatorPage(),
  foodItemsPage.routeName: (context) => foodItemsPage(),
  ProfilePage.routeName: (context) => ProfilePage(),
  verifyAuth.routeName: (context) => verifyAuth()
};
