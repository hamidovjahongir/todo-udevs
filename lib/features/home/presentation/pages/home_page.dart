import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_text.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/pages/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
          },
          icon: Icon(Icons.add),
        ),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TodoFailure) {
            return Center(
              child: WText(
                state.message,
                style: AppStyles.regular.copyWith(color: AppColors.red),
              ),
            );
          }
          if (state is TodoLoadSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: WText(todo.name ?? '-'),
                        subtitle: WText(todo.description ?? '-'),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
