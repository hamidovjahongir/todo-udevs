import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_button.dart';
import 'package:todo/core/widgets/w_scale_widget.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: WScaleAnimationWidget(
        onTap: () {
          context.read<TodoBloc>().add(
            AddTodoEvent(
              TodoModel(
                color: "sd,0xFF123456",
                name: 'Meeting Client (Japan)',
                description: 'Android apps and website online shop',
                onSaveTime: '5:51',
                onEndTime: '23:11',
                location: 'Stamford Bridge',
                time: '15 minutes before',
              ),
            ),
          );
          Navigator.pop(context);
        },
        child: WButton(
          height: 50,
          text: Text(
            'Add',
            style: AppStyles.regular.copyWith(color: AppColors.white),
          ),
        ).paddingOnly(right: 20, left: 20, bottom: 20),
      ),
    );
  }
}
