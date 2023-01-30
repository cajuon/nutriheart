import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'userData.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = '/ProfilePage';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;
  String bmi = 'Add height and weight';
  Map<String, dynamic> uData = {
    'name': 'Add name',
    'age': 'Add age',
    'gender': 'Add gender',
    'height': 'Add height',
    'weight': 'Add weight',
  };
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  List<String> gender = ['Male', 'Female'];
  String selectedGender = 'Male';

  getData(user) async {
    uData = (await userData().getUser(user.uid));
    double? height = double.tryParse(uData['height']);
    double? weight = double.tryParse(uData['weight']);
    if (height != null || weight != null) {
      height = height! / 100;
      double temp = weight! / (height * height);
      bmi = temp.toStringAsFixed(2);
    }
    setState(() {});
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    getData(user);
    super.initState();
  }

  clearController() async {
    setState(() {
      nameController.text = '';
      ageController.text = '';
      selectedGender = 'Male';
      heightController.text = '';
      weightController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(user);
    print(uData);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Nutriheart'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => FirebaseAuth.instance.signOut()),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    'Your Profile',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Divider(
                thickness: 5,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                uData['name'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Age: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                uData['age'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Gender: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                uData['gender'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Height in cm: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                uData['height'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Weight in kg: ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                uData['weight'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'BMI: ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                  child: Text(
                bmi,
                style: TextStyle(fontSize: 18),
              )),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: OutlinedButton(
                          onPressed: () {
                            EditProfile(context);
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(fontSize: 20),
                          ))))
            ]),
      ),
    );
  }

  void EditProfile(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * .75,
                  child: StickyHeader(
                      header: Container(
                        color: Colors.white,
                        height: 50,
                        child: Row(
                          children: [
                            Text(
                              ' Edit Profile',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.cancel),
                              color: Colors.purple,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      ),
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Name: ',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple))),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Age: ',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple))),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Gender: ',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(right: 12),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple))),
                                  value: selectedGender,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: gender.map((String activities) {
                                    return DropdownMenuItem(
                                      value: activities,
                                      child: Text(activities),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue!;
                                      // changeIndexAct(newValue);
                                    });
                                  },
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Height in cm: ',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: heightController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple))),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Weight in kg: ',
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: weightController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3, color: Colors.purple))),
                                ),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  'Save Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                onPressed: () async {
                                  final result = await userData().addUser(
                                      uid: user.uid,
                                      name: nameController.text,
                                      age: ageController.text,
                                      gender: selectedGender,
                                      height: heightController.text,
                                      weight: weightController.text);
                                  if (result!.contains('success')) {
                                    print(result);
                                  }
                                  clearController();
                                  getData(user);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ],
                      ))));
        });
  }
}



// class EditProfile extends StatelessWidget {
//   const EditProfile({super.key});

//   @override
//   Widget build(BuildContext context) => ProfileScreen(
//         providerConfigs: [EmailProviderConfiguration()],
//       );

 
// }
