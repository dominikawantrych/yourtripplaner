part of 'wish_cubit.dart';

@immutable
 class WishState {
  final List documents;
  final bool isLoading;
  final String errorMessage;

  const WishState({required this.documents, required this.isLoading, required this.errorMessage });
 }


