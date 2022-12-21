import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yourtripplaner/Features/add/cubit/add_cubit.dart';
import 'package:yourtripplaner/repositories/items_repository.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? _imageURL;
  String? _title;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ItemsRepository()),
      child: BlocConsumer<AddCubit, AddState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
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
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              title: const Text('Add upcoming trip'),
              actions: [
                IconButton(
                  onPressed:
                      _imageURL == null || _title == null || _date == null
                          ? null
                          : () {
                              context.read<AddCubit>().add(
                                    _title!,
                                    _imageURL!,
                                    _date!,
                                  );
                            },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            body: AddPageBody(
              onTitleChanged: (newValue) {
                setState(() {
                  _title = newValue;
                });
              },
              onImageUrlChanged: (newValue) {
                setState(() {
                  _imageURL = newValue;
                });
              },
              onDateChanged: (newValue) {
                setState(() {
                  _date = newValue;
                });
              },
              selectedDateFormatted:
                  _date == null ? null : DateFormat.yMMMMEEEEd().format(_date!),
            ),
          );
        },
      ),
    );
  }
}

class AddPageBody extends StatelessWidget {
  const AddPageBody({
    Key? key,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onImageUrlChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          TextField(
            onChanged: onTitleChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Spain',
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: onImageUrlChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'http:// ... .jpg',
              label: Text('Image URL'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 365 * 10),
                ),
              );

              onDateChanged(selectedDate);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 118, 178, 233),
              ),
            ),
            child: Text(selectedDateFormatted ?? 'Choose trip date'),
          ),
        ]);
  }
}
