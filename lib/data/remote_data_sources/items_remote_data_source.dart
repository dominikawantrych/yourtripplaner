import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ItemsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getItemsStream() {
    try {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('trip')
        .orderBy('date')
        .snapshots();
        return stream;
  } catch (error) {
    throw Exception(error.toString());
  }}
        
  

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('trip')
        .doc(id)
        .delete();
  }

  

  Future<void> add(
    String title,
    String imageURL,
    DateTime date,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('trip')
        .add(
      {
        'title': title,
        'imageURL': imageURL,
        'date': date,
      },
    );
  }
}
