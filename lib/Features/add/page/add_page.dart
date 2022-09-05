import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add/cubit/add_cubit.dart';

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
      create: (context) => AddCubit(),
      child: BlocBuilder<AddCubit, AddState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
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
            body: const AddPageBody(),
          );
        },
      ),
    );
  }
}

class AddPageBody extends StatelessWidget {
  const AddPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
