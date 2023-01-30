/* 
  This dart file containing a page displaying a list of food and its calorie value.
  There also a textfield that allow the user to enter characters to search the food.

  To use this file :-
  1) import this 'foodItemsPage.dart'
  2) call foodItemsPage() method to display this page.
*/

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutriheart/config/config.dart';
import 'package:http/http.dart' as http;

// declaring FoodItem class for object structure
class FoodItem {
  final int id;
  final String name;
  final String calorie;

  const FoodItem({required this.id, required this.name, required this.calorie});
}

// declaring foodItemsPage class as stateful widget
class foodItemsPage extends StatefulWidget {
  static String routeName = '/foodItems';
  const foodItemsPage({super.key});

  @override
  State<foodItemsPage> createState() => _foodItemsPageState();
}

class _foodItemsPageState extends State<foodItemsPage> {
  // Controllers
  var searchTextController =
      TextEditingController(); // for keeping track the characters entered by user

  // Variables
  List<FoodItem> allFoodItems =
      []; // for storing all FoodItem objects receive from API
  List<FoodItem> displayList = []; // for storing FoodItem objects to be display
  bool hasItem = false; // for keeping track if the search has result or not

  @override
  void initState() {
    super.initState();
    fetchFoodItems(); // call the method to receive all FoodItem objects at the start
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  // fetchFoodItems method for receiving all FoodItem objects
  fetchFoodItems() async {
    // send get request to the API using http library
    final url = Uri.parse('https://cajuon.github.io/data/fooditems.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // proceed to store the objects receive
      // decode the json receive from API
      final List<dynamic> jsonData = json.decode(response.body);

      // loop for initialize all FoodItem objects and insert into allFoodItems list
      for (Map<String, dynamic> item in jsonData) {
        FoodItem food = FoodItem(
            id: int.parse(item['id']),
            name: item['name'],
            calorie: item['calorie']);
        allFoodItems.add(food);
      }
      print(allFoodItems
          .length); // for cross checking if all FoodItem objects inserted

      // insert all FoodItem objects for the first display without any search
      displayList.addAll(allFoodItems);
      hasItem = true;
      if (!mounted) return;
      setState(() {});
    } else {
      // throw Exception if the API cannot be reached
      throw Exception('Failed to load food items');
    }
  }

  // filterSearchResults method for filter only FoodItem objects that were searched by user
  filterSearchResults(String string) {
    List<FoodItem> tempList = [];
    tempList.addAll(
        allFoodItems); // insert all FoodItem objects as refence for filtering
    string = string.toLowerCase();
    if (string.isNotEmpty) {
      List<FoodItem> resultList = [];
      // filter each FoodItem objects if its name contain user's entered character
      tempList.forEach((item) {
        String foodName = item.name.toLowerCase();
        if (foodName.contains(string)) {
          resultList.add(item);
        }
      });
      setState(() {
        if (resultList.isEmpty) {
          hasItem = false;
        }
        displayList.clear();
        displayList
            .addAll(resultList); // update the displayList with new resultList
      });
    } else {
      setState(() {
        hasItem = true;
        displayList.clear();
        displayList.addAll(
            allFoodItems); // update the displayList to show all FoodItem objects
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Fix 'bottom overflowed by pixels' error
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Nutriheart'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchTextController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  )),
              Expanded(
                child: hasItem
                    ? ListView.builder(
                        itemCount: displayList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('${displayList[index].name}'),
                              subtitle: Text('${displayList[index].calorie}'),
                            ),
                          );
                        })
                    : const Center(
                        child: Text('No result found.'),
                      ),
              ),
            ],
          ),
        ));
  }
}
