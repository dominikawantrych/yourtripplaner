import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yourtripplaner/Features/models/details_model.dart';

class DetailsRepository {
  Stream<List<DetailsModel>> getDetailsStream() {
    return FirebaseFirestore.instance
        .collection('todo')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docs) {
        return DetailsModel(id: docs.id, title: docs['title']);
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('todo').doc(id).delete();
  }

  Future<DetailsModel> get({required String id}) async {
    final doc =
        await FirebaseFirestore.instance.collection('todo').doc(id).get();
    return DetailsModel(
      id: doc.id,
      title: doc['title'],
    );
  }

  Future<void> add(
    String title,
  ) async {
    await FirebaseFirestore.instance.collection('todo').add({'title': title});
  }
}
