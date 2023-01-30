import 'package:cloud_firestore/cloud_firestore.dart';

class userData {
  Future<String?> addUser({
    required String uid,
    required String name,
    required String age,
    required String gender,
    required String height,
    required String weight,
  }) async {
    try {
      CollectionReference userData =
          FirebaseFirestore.instance.collection('userData');
      // Call the user's CollectionReference to add a new user
      await userData.doc(uid).set({
        'name': name,
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
      });
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<Map<String, dynamic>> getUser(String uid) async {
    try {
      CollectionReference userData =
          FirebaseFirestore.instance.collection('userData');
      final snapshot = await userData.doc(uid).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data;
    } catch (e) {
      Map<String, dynamic> noData = {
        'name': 'Add name',
        'age': 'Add age',
        'gender': 'Add gender',
        'height': 'Add height',
        'weight': 'Add weight',
      };
      return noData;
    }
  }
}
