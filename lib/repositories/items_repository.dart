import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourtripplaner/Features/models/item_model.dart';

import 'package:yourtripplaner/data/remote_data_sources/items_remote_data_source.dart';

class ItemsRepository {
  ItemsRepository(
    this.itemsRemoteDataSource,
  );

  final ItemsRemoteDataSource itemsRemoteDataSource;

  Stream<List<ItemModel>> getItemsStream() {
    return itemsRemoteDataSource.getItemsStream().map((querySnapshot) {
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
    return itemsRemoteDataSource.delete(id: id);
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime date,
  ) {
    return itemsRemoteDataSource.add(title, imageURL, date);
  }
}
