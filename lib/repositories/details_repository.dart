import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yourtripplaner/Features/models/details_model.dart';

class DetailsRepository {
  Stream<List<DetailsModel>> getDetailsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('todo')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docs) {
        return DetailsModel(id: docs.id, title: docs['title']);
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance.collection('users')
        .doc(userID).collection('todo').doc(id).delete();
  }

  Future<DetailsModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc =
        await FirebaseFirestore.instance.collection('users')
        .doc(userID).collection('todo').doc(id).get();
    return DetailsModel(
      id: doc.id,
      title: doc['title'],
    );
  }

  Future<void> add(
    String title,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance.collection('users')
        .doc(userID).collection('todo').add({'title': title});
  }
}
