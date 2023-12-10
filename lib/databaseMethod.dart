import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUser(String uderId, Map<String, dynamic> userInfo) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(uderId)
        .set(userInfo);
  }
}
