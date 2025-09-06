import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extensions/gap_x_extensions.dart';
import 'package:todo/core/extensions/padding_x_extensions.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_button.dart';
import 'package:todo/core/widgets/w_text_field.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/color_picker_popup.dart';
import 'package:todo/features/home/presentation/widgets/time_range_picker.dart';

final Map<String, Color> colors = {
  "red": AppColors.red,
  "pink": AppColors.pink,
  "blue": AppColors.blue,
  "orange": AppColors.orange,
};

class AddPage extends StatefulWidget {
  final TodoModel? todo;
  final DateTime? selectedDate;

  const AddPage({super.key, this.todo, this.selectedDate});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  late String startTime = '';
  late String endTime = '';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String selectedColorKey = "red";

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      nameController.text = widget.todo!.name ?? '';
      descriptionController.text = widget.todo!.description ?? '';
      locationController.text = widget.todo!.location ?? '';
      selectedColorKey = widget.todo!.color ?? '';
      startTime = widget.todo!.onSaveTime ?? '';
      endTime = widget.todo!.onEndTime ?? '';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void onSave() {
    if (_globalKey.currentState!.validate()) {
      final todo = TodoModel(
        color: selectedColorKey,
        name: nameController.text,
        description: descriptionController.text,
        location: locationController.text,
        onSaveTime: startTime,
        onEndTime: endTime,
        time: widget.selectedDate.toString(),
        addTime: DateTime.now().toString(),
      );

      if (widget.todo != null && widget.todo!.id != null) {
        // Update
        log('user id: ${widget.todo!.id}');
        context.read<TodoBloc>().add(UpdateTodoEvent(widget.todo!.id!, todo));
        Navigator.pop(context, todo);
      } else {
        // Add
        context.read<TodoBloc>().add(AddTodoEvent(todo));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.gray500,
                  size: 27,
                ),
              ),
              35.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  WTextField(
                    controller: nameController,
                    fieldName: 'Event name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Todo Name';
                      }
                      return null;
                    },
                  ),

                  WTextField(
                    maxLines: 3,

                    controller: descriptionController,
                    fieldName: 'Event description',
                  ),

                  WTextField(
                    controller: locationController,
                    fieldName: 'Event location',
                    suffixIcon: Icon(Icons.location_on, color: AppColors.blue),
                  ),

                  ColorPickerField(
                    initialColorKey: selectedColorKey,
                    onChanged: (colorKey) {
                      setState(() {
                        selectedColorKey = colorKey;
                      });
                      debugPrint("Tanlangan rang: $colorKey");
                    },
                  ),

                  TimeRangePicker(
                    onChanged: (start, end) {
                      startTime = start;
                      endTime = end;
                    },
                    start: startTime,
                    end: endTime,
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: WButton(
        onTap: onSave,
        height: 50,
        text: Text(
          'Add',
          style: AppStyles.regular.copyWith(color: AppColors.white),
        ),
      ).paddingOnly(right: 20, left: 20, bottom: 20),
    );
  }
}
