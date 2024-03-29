import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yourtripplaner/Features/details/cubit/details_cubit.dart';
import 'package:yourtripplaner/app/core/enums.dart';
import 'package:yourtripplaner/data/remote_data_sources/details_data_source.dart';
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
      create: (context) =>
          DetailsCubit(DetailsRepository(DetailsRemoteDataSource())),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromARGB(255, 118, 178, 233),
                      Color.fromARGB(255, 173, 211, 248),
                      Color.fromARGB(255, 187, 217, 246),
                      Color.fromARGB(255, 202, 226, 250),
                      Color.fromARGB(255, 216, 231, 246),
                      Color.fromARGB(255, 226, 234, 241),
                    ],
                  ),
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              title: const Text('Before the Trip'),
            ),
            body: BlocProvider(
              create: (context) =>
                  DetailsCubit(DetailsRepository(DetailsRemoteDataSource()))
                    ..start(),
              child: BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const Center(child: Text('Please wait'));

                    case Status.error:
                      return const Center(child: Text('Something went wrong'));

                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 123, 183, 233)),
                      );

                    case Status.success:
                      final detailsModels = state.docs;

                      return ListView(
                        children: [
                          for (final detailsModel in detailsModels) ...[
                            Dismissible(
                              key: ValueKey(detailsModel.id),
                              onDismissed: (_) {
                                context
                                    .read<DetailsCubit>()
                                    .remove(documentID: detailsModel.id);
                              },
                              child: CategoryWidget(
                                detailsModel.title,
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    style: GoogleFonts.montserrat(),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                233, 182, 217, 240)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                233, 182, 217, 240)),
                                      ),
                                      hintText: 'Book Flights',
                                      prefixIcon: Icon(
                                        Ionicons.today_outline,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<DetailsCubit>()
                                        .add(title: controller.text);
                                    controller.clear();
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.black38),
                                ),
                              ],
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
          color: const Color.fromARGB(31, 191, 208, 217),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 238, 238, 238)),
            BoxShadow(
              offset: Offset(-5, -5),
              blurRadius: 1.0,
              color: Color.fromARGB(233, 214, 230, 246),
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
