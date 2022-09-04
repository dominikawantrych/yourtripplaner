import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plan Your Trip'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: BlocProvider(
            create: (context) => HomeCubit()..start(),
            child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return Text(
                  'Problem has occured: ${state.errorMessage}',
                );
              }
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final documents = state.documents;

              return ListView(
                children: [
                  for (final document in documents) ...[
                    Dismissible(
                      key: ValueKey(document.id),
                      onDismissed: (_) {
                        FirebaseFirestore.instance
                            .collection('trip')
                            .doc(document.id)
                            .delete();
                      },
                      child: ListViewItem(document['title']),
                    ),
                  ],
                ],
              );
            })));
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Text(title),
    );
  }
}
