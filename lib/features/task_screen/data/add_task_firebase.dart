import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> addData(String title, String dateString) async {
    try {
      await FirebaseFirestore.instance.collection('task').add({
        'title': title,
        'date': dateString, // Store the date as a string
      });
      print('Data added successfully!');
    } catch (error) {
      print('Error adding data: $error');
      throw error; // Rethrow the error to propagate it to the caller
    }
  }
}
