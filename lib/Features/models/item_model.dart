import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.date,
  });
  final String id;

  final String title;
  final String imageURL;
  final DateTime date;

  String daysLeft() {
    return date.difference(DateTime.now()).inDays.toString();
  }

  String dateFormatted() {
    return DateFormat.yMMMEd().format(date);
  }
}
