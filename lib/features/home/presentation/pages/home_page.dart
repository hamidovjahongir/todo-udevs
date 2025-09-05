import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_container.dart';
import 'package:todo/core/widgets/w_scale_widget.dart';
import 'package:todo/core/widgets/w_text.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/pages/add_page.dart';
import 'package:todo/features/home/presentation/widgets/todo_items.dart';

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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WText(
                  'Schedule',
                  style: AppStyles.semiBold.copyWith(fontSize: 14),
                ),

                // ADD
                WScaleAnimationWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  },

                  child: WContainer(
                    width: 105,
                    height: 30,
                    radius: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WText(
                          '+ Add Event',
                          style: AppStyles.semiBold.copyWith(
                            color: AppColors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.height,

            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is TodoFailure) {
                  return Expanded(
                    child: Center(
                      child: WText(
                        state.message,
                        style: AppStyles.regular.copyWith(color: AppColors.red),
                      ),
                    ),
                  );
                }
                if (state is TodoLoadSuccess) {
                  if (state.todos.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: WText('Malumot yoq', style: AppStyles.semiBold),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.todos.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return TodoItems(todo: state.todos[index]);
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
