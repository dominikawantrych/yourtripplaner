import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(const AddState());

  Future<void> add(
    String title,
    String imageURL,
    DateTime date,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('trip').add(
        {
          'title': title,
          'imageURL': imageURL,
          'date': date,
        },
      );
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
