import 'package:yourtripplaner/Features/models/wish_model.dart';
import 'package:yourtripplaner/data/remote_data_sources/wish_remote_data_source.dart';

class WishRepository {
  WishRepository(this.wishRemoteDataSource);

  final WishRemoteDataSource wishRemoteDataSource;

  Stream<List<WishModel>> getWishStream() {
    return wishRemoteDataSource.getWishStream().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return WishModel(
          id: doc.id,
          imageURL: doc['imageURL'],
          title: doc['title'],
        );
      }).toList();
    });
  }

  Future<void> add({required String imageURL, title}) {
    return wishRemoteDataSource.add(imageURL: imageURL, title: title);
  }

  Future<void> delete({required String documentID}) {
    return wishRemoteDataSource.delete(documentID: documentID);
  }
}
