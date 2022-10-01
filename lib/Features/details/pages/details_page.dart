
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yourtripplaner/Features/details/cubit/details_cubit.dart';
import 'package:yourtripplaner/app/core/enums.dart';
import 'package:yourtripplaner/repositories/details_repository.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(DetailsRepository()),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              title: const Text('Things To Do'),
            ),
            
            body: BlocProvider(
              create: (context) => DetailsCubit(DetailsRepository())..start(),
              child: BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const Center(child: Text('Please wait'));

                    case Status.error:
                      return const Center(child: Text('Something went wrong'));

                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );

                    case Status.success:
                      final detailsModels = state.docs;

                      return ListView(
                        children: [
                          for (final detailsModel in detailsModels) ...[
                            Dismissible(
                              key: ValueKey(detailsModel.id),
                              onDismissed: (_) {
                                context.read<DetailsCubit>().remove(documentID: detailsModel.id);
                              },
                              child: CategoryWidget(
                                detailsModel.title,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(233, 56, 183, 186)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(233, 56, 183, 186)),
                                ),
                                hintText: 'Book Flights',
                                prefixIcon: Icon(
                                  Ionicons.today_outline,
                                  color: Colors.black38,
                                ),
                                suffixIcon: IconButton(onPressed: () {
                                  context.read<DetailsCubit>().add(title: controller.text);
                                  controller.clear();
                                }, icon:  icon(Icons.add, color: Colors.blue));
                              ),
                            ),
                          ),
                        ],
                      );
                  }
                  
                },
              ),
            ),
          );
        },
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
