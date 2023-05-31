import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productivityapp/presentation/state/tasks_cubit_expansion_tile/expansion_cubit.dart';
import 'package:productivityapp/presentation/ui/screens/tasks_screen/tasks_screen.dart';
import 'package:productivityapp/presentation/ui/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (
        context,
      ) =>
          ExpansionCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.dark(),
        home: const TasksScreen(),
      ),
    );
  }
}
