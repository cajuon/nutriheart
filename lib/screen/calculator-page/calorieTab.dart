import 'package:flutter/material.dart';

class Calorie extends StatefulWidget {
  const Calorie({super.key});

  @override
  State<Calorie> createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> with AutomaticKeepAliveClientMixin {
  // Inputs
  TextEditingController ageInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();

  int currentIndexGen = 0; // for gender
  int currentIndexAct = 0; // for activity

  List<String> activities = [
    'Sedentary (little or no exercise)',
    'Light (exercise 1-3 times/week)',
    'Moderate (exercise 4-5 times/week)',
    'Active (exercise 6-7 times/week)',
    'Very active (hard exercise 6-7 times/week)'
  ];
  String? selectedActivity = 'Sedentary (little or no exercise)';
  String calorieResult = '';
  String weightLoss = '';
  String extremeLoss = '';

  void changeIndexGen(int index) {
    setState(() {
      currentIndexGen = index;
    });
  }

  void changeIndexAct(String activity) {
    if (activity == activities[0]) {
      currentIndexAct = 0;
    } else if (activity == activities[1]) {
      currentIndexAct = 1;
    } else if (activity == activities[2]) {
      currentIndexAct = 2;
    } else if (activity == activities[3]) {
      currentIndexAct = 3;
    } else {
      currentIndexAct = 4;
    }
  }

  void calculateCalorie(
      int age, int indexGen, double height, double weight, int indexAct) {
    // Basal Metabolic Rate
    double manBMR =
        (13.397 * weight) + (4.799 * height) - (5.677 * age) + 88.362;
    double womanBMR =
        (9.247 * weight) + (3.098 * height) - (4.330 * age) + 447.593;
    double result;
    String temp = '';
    String lossTemp = '';
    String extremeTemp = '';

    // BMR must be multiplied by rate (based on the activeness of daily activity)
    if (indexGen == 0) {
      if (indexAct == 0) {
        result = manBMR * 1.1;
      } else if (indexAct == 1) {
        result = manBMR * 1.25;
      } else if (indexAct == 2) {
        result = manBMR * 1.35;
      } else if (indexAct == 3) {
        result = manBMR * 1.45;
      } else {
        result = manBMR * 1.575;
      }
    } else {
      if (indexAct == 0) {
        result = womanBMR * 1.1;
      } else if (indexAct == 1) {
        result = womanBMR * 1.25;
      } else if (indexAct == 2) {
        result = womanBMR * 1.35;
      } else if (indexAct == 3) {
        result = womanBMR * 1.45;
      } else {
        result = womanBMR * 1.575;
      }
    }

    temp = result.toStringAsFixed(0);
    lossTemp = (result - 500.0).toStringAsFixed(0);
    extremeTemp = (result - 1000.0).toStringAsFixed(0);

    setState(() {
      calorieResult = temp;
      weightLoss = lossTemp;
      extremeLoss = extremeTemp;
    });
  }

  Widget genderButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: (() {
            changeIndexGen(index);
          }),
          child: Text(
            value,
            style: TextStyle(
              color: currentIndexGen == index ? Colors.white : Colors.grey,
            ),
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Age: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: ageInput,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: "e.g. 16",
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Gender: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            genderButton("Man", Colors.blue, 0),
            genderButton("Woman", Colors.pink, 1)
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Height: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: heightInput,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: "in cm",
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Weight: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: weightInput,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: "in kg",
              filled: true,
              fillColor: Colors.grey.shade300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Activity: ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.maxFinite,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 3, color: Colors.purple))),
            value: selectedActivity,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: activities.map((String activities) {
              return DropdownMenuItem(
                value: activities,
                child: Text(activities),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedActivity = newValue!;
                changeIndexAct(newValue);
              });
            },
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          width: double.maxFinite,
          height: 40,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple),
              onPressed: () {
                int age = int.parse(ageInput.value.text);
                double height = double.parse(heightInput.value.text);
                double weight = double.parse(weightInput.value.text);
                calculateCalorie(
                    age, currentIndexGen, height, weight, currentIndexAct);
                // hide the keyboard after user click Calculate
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        DataTable(columns: [
          DataColumn(
              label: Text(
            '',
          )),
          DataColumn(
              label: Text(
            'Result',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ))
        ], rows: [
          DataRow(cells: [
            DataCell(Text('Maintain weight')),
            DataCell(Text('$calorieResult calories / day')),
          ]),
          DataRow(cells: [
            DataCell(Text('Weight loss')),
            DataCell(Text('$weightLoss calories / day')),
          ]),
          DataRow(cells: [
            DataCell(Text('Extreme weight loss')),
            DataCell(Text('$extremeLoss calories / day')),
          ]),
        ]),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'based on Revised Harris-Benedict Equation',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
