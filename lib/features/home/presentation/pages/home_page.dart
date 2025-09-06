import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_container.dart';
import 'package:todo/core/widgets/w_scale_widget.dart';
import 'package:todo/core/widgets/w_text.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
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

  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final todos = context.select<TodoBloc, List<TodoModel>>((bloc) {
      final stt = bloc.state;
      if (stt is TodoLoadSuccess) return stt.todos;
      return [];
    });

    final filtered = todos.where((todo) {
      if (todo.time == null || todo.time!.isEmpty) return false;
      final d = DateTime.parse(todo.time!);

      return d.year == selectedDate.year &&
          d.month == selectedDate.month &&
          d.day == selectedDate.day;
    }).toList();

    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    int startWeekday = firstDayOfMonth.weekday % 7;
    int totalDays = lastDayOfMonth.day;
    List<Widget> dayWidgets = [];

    final saveDays = todos
        .where((todo) => todo.time != null && todo.time!.isNotEmpty)
        .map((todo) {
          final d = DateTime.parse(todo.time!);
          return DateTime(d.year, d.month, d.day);
        })
        .toList();
    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(SizedBox.shrink());
    }

    for (int i = 1; i <= totalDays; i++) {
      DateTime day = DateTime(currentMonth.year, currentMonth.month, i);
      bool isSelected =
          day.day == selectedDate.day &&
          day.month == selectedDate.month &&
          day.year == selectedDate.year;
      bool hasData = saveDays.contains(day);
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = day;
            });
            log('selected day $selectedDate');
          },
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : Colors.transparent,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WText(
                    i.toString(),
                    style: AppStyles.semiBold.copyWith(
                      color: isSelected ? AppColors.white : AppColors.black,
                    ),
                  ),
                  if (hasData) Text('asd', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WText(
              DateFormat('EEEE').format(selectedDate),
              style: AppStyles.semiBoldWithSize(14),
            ),
            WText(
              DateFormat('d MMMM yyyy').format(selectedDate),
              style: AppStyles.regularWithSize(10),
            ),
            30.height,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WText(
                  DateFormat('MMMM').format(currentMonth),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month - 1,
                            1,
                          );
                        });
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        setState(() {
                          currentMonth = DateTime(
                            currentMonth.year,
                            currentMonth.month + 1,
                            1,
                          );
                        });
                      },
                    ),
                  ],
                ),

                //
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WText(
                  "Sun",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Mon",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Tue",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Wed",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Thu",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Fri",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
                WText(
                  "Sat",
                  style: AppStyles.regular.copyWith(
                    color: AppColors.grayNeutral,
                  ),
                ),
              ],
            ),

            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 7,
                children: dayWidgets,
              ),
            ),

            //
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
                  if (filtered.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: WText('Malumot yoq', style: AppStyles.semiBold),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        log('Time: ${filtered[index].time}');
                        return TodoItems(todo: filtered[index]);
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
