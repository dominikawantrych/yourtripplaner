
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_model.freezed.dart';

@freezed
class DetailsModel with _$DetailsModel {
  factory DetailsModel({
    required String id,
    required String title,
    
 
  }) = _DetailsModel;


  
}
