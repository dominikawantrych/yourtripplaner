import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_model.freezed.dart';

@freezed
class WishModel with _$WishModel {
  factory WishModel({
    required String id,
    required String imageURL,
    required String title,
  }) = _WishModel;
}
