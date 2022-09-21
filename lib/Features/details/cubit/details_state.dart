part of 'details_cubit.dart';

class DetailsState {
  DetailsState({
    required this.docs,
    
    required this.errorMessage,
    required this.isLoading,
  });
  final  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  final bool isLoading;
  final String errorMessage;
}
