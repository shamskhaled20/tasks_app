import 'package:cloud_firestore/cloud_firestore.dart';


class FireBaseServiceGetTasks {
  static Stream<List<Map<String, dynamic>>> getTasks() {
    return FirebaseFirestore.instance.collection('task').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }
}