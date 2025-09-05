import 'package:flutter/material.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_text.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/presentation/pages/details_page.dart';

class TodoItems extends StatefulWidget {
  final TodoModel todo;
  const TodoItems({super.key, required this.todo});

  @override
  State<TodoItems> createState() => _TodoItemsState();
}

const Map<String, Color> colors = {
  "red": AppColors.red,
  "pink": AppColors.pink,
  "blue": AppColors.blue,
  "orange": AppColors.orange,
};

class _TodoItemsState extends State<TodoItems> {
  Color _parseColor(String? key) {
    if (key == null || key.isEmpty) return AppColors.blue;
    return colors[key] ?? AppColors.blue;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = _parseColor(widget.todo.color);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(todo: widget.todo),
          ),
        );
      },
      child: Ink(
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WText(
                  widget.todo.name ?? '-',
                  style: AppStyles.semiBold.copyWith(color: color),
                ),

                WText(
                  widget.todo.description ?? '-',
                  style: AppStyles.regular.copyWith(fontSize: 10, color: color),
                ),
                10.height,
                Row(
                  children: [
                    Icon(Icons.access_time_filled, color: color),
                    3.width,
                    WText(
                      widget.todo.onSaveTime ?? '-',
                      style: AppStyles.regular.copyWith(color: color),
                    ),
                    WText(
                      ' - ',
                      style: AppStyles.regular.copyWith(color: color),
                    ),
                    WText(
                      widget.todo.onEndTime ?? '-',
                      style: AppStyles.regular.copyWith(color: color),
                    ),
                  ],
                ),
              ],
            ).paddingAll(10),
          ],
        ),
      ),
    );
  }
}
