import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourtripplaner/Features/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('trip')
        .orderBy('date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['imageURL'],
            date: (doc['date'] as Timestamp).toDate(),
          );
        },
      ).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('trip').doc(id).delete();
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime date,
  ) async {
    await FirebaseFirestore.instance.collection('trip').add(
      {
        'title': title,
        'imageURL': imageURL,
        'date': date,
      },
    );
  }
}
