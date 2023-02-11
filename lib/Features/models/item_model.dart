import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel  with _$ItemModel {
  const ItemModel._();
  factory ItemModel({
    required String id,
    required String title,
    required  String imageURL,
    required DateTime date,
  }) = _ItemModel;
  

  String daysLeft() {
    return date.difference(DateTime.now()).inDays.toString();
  }

  String dateFormatted() {
    return DateFormat.yMMMEd().format(date);
  }
}
