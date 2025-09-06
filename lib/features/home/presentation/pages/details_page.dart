import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_button.dart';
import 'package:todo/core/widgets/w_container.dart';
import 'package:todo/core/widgets/w_text.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/pages/add_page.dart';
import 'package:todo/features/home/presentation/widgets/todo_items.dart';

class DetailsPage extends StatefulWidget {
  final TodoModel todo;
  const DetailsPage({super.key, required this.todo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String formatTimeAgo(String savedTimeString) {
    try {
      final savedTime = DateTime.parse(savedTimeString);
      final now = DateTime.now();

      final difference = now.difference(savedTime);

      if (difference.inSeconds < 60) {
        return 'just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else if (difference.inDays < 30) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months months ago';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years years ago';
      }
    } catch (e) {
      return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = parseColor(widget.todo.color);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoSuccess) {
            final todoIndex = state.todos.indexWhere(
              (element) => element.id == widget.todo.id,
            );

            if (todoIndex < 0 || todoIndex >= state.todos.length) {
              return const Center(child: WText('-'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WContainer(
                            onTap: () => Navigator.pop(context),
                            width: 40,
                            height: 40,
                            radius: 100,
                            color: AppColors.white,
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddPage(todo: state.todos[todoIndex]),
                                  ),
                                ),
                                child: Icon(Icons.edit, color: AppColors.white),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddPage(todo: state.todos[todoIndex]),
                                  ),
                                ),

                                child: WText(
                                  'Edit',
                                  style: AppStyles.regular.copyWith(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      20.height,
                      if (todoIndex >= 0 && todoIndex < state.todos.length) ...{
                        WText(
                          state.todos[todoIndex].name ?? '-',
                          style: AppStyles.semiBold.copyWith(
                            color: AppColors.white,
                            fontSize: 26,
                          ),
                        ),
                      } else ...{
                        const WText('-'), // xavfsizlik uchun fallback
                      },
                      WText(
                        state.todos[todoIndex].description ?? '',
                        style: AppStyles.regular.copyWith(
                          color: AppColors.white,
                          fontSize: 10,
                        ),
                      ),
                      10.height,
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.access_time_filled_outlined,
                            color: AppColors.white,
                          ),
                          WText(
                            '${state.todos[todoIndex].onSaveTime} - ${state.todos[todoIndex].onEndTime}',
                            style: AppStyles.regular.copyWith(
                              color: AppColors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      10.height,
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.location_on, color: AppColors.white),
                          WText(
                            state.todos[todoIndex].location ?? '-',
                            style: AppStyles.regular.copyWith(
                              color: AppColors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(right: 20, left: 20, top: 50, bottom: 20),
                ),
                25.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WText('Reminder', style: AppStyles.semiBold),
                    10.height,
                    WText(
                      formatTimeAgo(
                        state.todos[todoIndex].addTime ?? '',
                      ), // String vaqtni metodga uzatyapmiz
                      style: AppStyles.regular.copyWith(
                        color: AppColors.grayDark,
                        fontSize: 16,
                      ),
                    ),
                    20.height,
                    WText('Description', style: AppStyles.semiBold),

                    WText(
                      state.todos[todoIndex].description ?? '-',
                      style: AppStyles.regular.copyWith(
                        color: AppColors.grayDark,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 20),
              ],
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: WButton(
        // padding: EdgeInsets.zero,
        onTap: () {
          context.read<TodoBloc>().add(RemoveTodoEvent(widget.todo.id!));
          Navigator.pop(context);
        },
        color: AppColors.softPink,
        height: 55,
        child: Row(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: AppColors.red),
            Text(
              'Delete Event',
              style: AppStyles.regular.copyWith(fontSize: 16),
            ),
          ],
        ),
      ).paddingOnly(right: 20, left: 20),
    );
  }
}
