import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add/page/add_page.dart';

import 'package:yourtripplaner/Features/details/pages/details_page.dart';
import 'package:yourtripplaner/Features/home/cubit/home_cubit.dart';

import 'package:yourtripplaner/Features/models/item_model.dart';
import 'package:yourtripplaner/Features/weather/pages/weather_page.dart';
import 'package:yourtripplaner/Features/wish_list/wish_list/wish_list.dart';
import 'package:yourtripplaner/auth/pages/user_profile.dart';
import 'package:yourtripplaner/repositories/items_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Plan Your Trip '),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 2) {
          return WishList();
        }
        if (currentIndex == 1) {
          return const WeatherPage();
        }
        if (currentIndex == 0) {
          return const HomePage();
        }

        return BlocProvider(
          create: (context) => HomeCubit(ItemsRepository())..start(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final itemModels = state.items;
              if (itemModels.isEmpty) {
                return const SizedBox.shrink();
              }
              if (state.loadingErrorOccured) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  for (final itemModel in itemModels) ...[
                    Dismissible(
                      key: ValueKey(itemModel.id),
                      background: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 32),
                              child: Icon(
                                Icons.delete,
                              ),
                            )),
                      ),
                      confirmDismiss: (direction) async {
                        return direction == DismissDirection.endToStart;
                      },
                      onDismissed: (direction) {
                        context
                            .read<HomeCubit>()
                            .remove(documentID: itemModel.id);
                      },
                      child: ListViewItem(
                        itemModel: itemModel,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 118, 178, 233),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.travel_explore,
              color: Color.fromARGB(255, 118, 178, 233),
            ),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sunny_snowing,
              color: Color.fromARGB(255, 118, 178, 233),
            ),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 118, 178, 233),
            ),
            label: 'Wish List',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 150, 196, 233),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(id: itemModel.id),
        ));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
                color: Colors.black12,
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32),
                      ),
                      color: Colors.black12,
                      image: DecorationImage(
                        image: NetworkImage(
                          itemModel.imageURL,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                itemModel.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                itemModel.dateFormatted(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              itemModel.daysLeft(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('days left'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
