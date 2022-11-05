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
  
}
