import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourtripplaner/Features/models/item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = FirebaseFirestore.instance
        .collection('trip')
        .orderBy('date')
        .snapshots()
        .listen((items) {
      final itemModels = items.docs.map((doc) {
        return ItemModel(
          id: doc.id,
          title: doc['title'],
          imageURL: doc['imageURL'],
          date: (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
      emit(
        HomeState(items: itemModels),
      );
    })
      ..onError((error) {
        emit(
          const HomeState(loadingErrorOccured: true),
        );
      });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('trip')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(const HomeState(
        removingErrorOccured: true,
      ));
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}