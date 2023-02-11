

import 'package:yourtripplaner/Features/models/details_model.dart';
import 'package:yourtripplaner/data/remote_data_sources/details_data_source.dart';

class DetailsRepository {
  DetailsRepository(this.detailsRemoteDataSource,);

  final DetailsRemoteDataSource detailsRemoteDataSource;

  Stream<List<DetailsModel>> getDetailsStream() {
    
    return detailsRemoteDataSource.getDetailsStream()
        .map((querySnapshot) {
      return querySnapshot.docs.map((docs) {
        return DetailsModel(id: docs.id, title: docs['title'],  );
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    
    return detailsRemoteDataSource.delete(id: id);
  }

  

  Future<void> add(
    String title,
  )  {
    return detailsRemoteDataSource.add(title);
  }
}
