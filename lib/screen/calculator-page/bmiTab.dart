import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> with AutomaticKeepAliveClientMixin {
  TextEditingController heightInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();
  double bmiValue = 0;
  String bmiResult = '';

  void calculateBMI(double height, double weight) {
    double result = weight / (height * height / 10000);
    bmiValue = result; // for bmiCategories
    String temp = result.toStringAsFixed(2);
    setState(() {
      bmiResult = temp;
    });
  }

  Widget bmiCategories() {
    if (bmiValue == 0) {
      return Container(
        color: Colors.white,
      );
    }
    if (bmiValue < 18.5) {
      return Container(
        color: Colors.blue.shade500,
        child: Text(
          'Underweight',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );
    } else if (bmiValue >= 18.5 && bmiValue < 25.0) {
      return Container(
        color: Colors.green.shade500,
        child: Text(
          'Normal',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );
    } else if (bmiValue >= 25.0 && bmiValue < 30.0) {
      return Container(
        color: Colors.orange.shade500,
        child: Text(
          'Overweight',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      return Container(
        color: Colors.red,
        child: Text(
          'Obese',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );
    }
    throw 'Error';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            Container(
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple),
                  onPressed: () {
                    double height = double.parse(heightInput.value.text);
                    double weight = double.parse(weightInput.value.text);
                    calculateBMI(height, weight);
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
            const Text(
              'Your BMI:',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                child: Column(
              children: [
                Text(
                  '$bmiResult',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple),
                ),
                const SizedBox(
                  height: 20,
                ),
                bmiCategories()
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
