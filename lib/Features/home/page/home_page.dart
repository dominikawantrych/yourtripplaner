import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add/page/add_page.dart';
import 'package:yourtripplaner/Features/home/cubit/home_cubit.dart';
import 'package:yourtripplaner/Features/models/item_model.dart';
import 'package:yourtripplaner/Features/weather/pages/weather_page.dart';
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
        title: const Text('Plan Your Trip'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (context) {
          if (currentIndex == 1) {
            return const WeatherPage();
          }
          if (currentIndex == 0 ) {}
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
                        child: ListViewItem(itemModel: itemModel),
                      ),
                    ],
                  ],
                );
              },
            ),
          );
          
        },
      ),
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
            icon: Icon(Icons.travel_explore),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny_snowing),
            label: 'Weather',
          ),
        ],
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
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
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
            )));
  }
  
}
