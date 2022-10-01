part of 'details_cubit.dart';

class DetailsState {
  DetailsState({
     this.docs = const [],
    this.status = Status.initial,
     required this.errorMessage,
    
    }
  );
  final  List<DetailsModel> docs;
  final Status status;
 
  final String? errorMessage;
}
