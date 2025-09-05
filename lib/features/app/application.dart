import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/di/injection_container.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<TodoBloc>())],
      child: MaterialApp(home: HomePage()),
    );
  }
}
