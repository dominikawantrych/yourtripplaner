part of 'wish_list_cubit.dart';

@immutable
class WishListState {
  final List<WishModel> documents;
  final bool isloading;
  final String errorMessage;

  const WishListState({
    required this.documents,
    required this.isloading,
    required this.errorMessage,
  });
}
