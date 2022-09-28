import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
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
                    style: GoogleFonts.montserrat(),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(233, 56, 183, 186)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 2, color: Color.fromARGB(233, 56, 183, 186)),
                      ),
                      hintText: 'Book Flights',
                      prefixIcon: Icon(
                        Ionicons.today_outline,
                        color: Colors.black38,
                      ),
                    ),
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
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: const Offset(5, 5),
                blurRadius: 6.0,
                color: Colors.grey.shade200),
            const BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 6.0,
              color: Color.fromARGB(233, 187, 250, 251),
            )
          ]),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18,
        ),
      ),
    );
  }
}
