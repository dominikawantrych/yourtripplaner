import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/details/cubit/details_cubit.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        title: const Text('Things To Do'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('todo').add({
            'title': controller.text,
          });
          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => DetailsCubit()..start(),
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Center(child: Text('Problem occured'));
            }
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }
            final document = state.docs;

            return ListView(
              children: [
                for (final document in document) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('todo')
                          .doc(document.id)
                          .delete();
                    },
                    child: CategoryWidget(
                      document['title'],
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      color: Colors.black12,
      child: Text(title),
    );
  }
}
