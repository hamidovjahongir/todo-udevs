import 'package:todo/features/home/data/models/todo_model.dart';

extension TodoModelX on TodoModel {
  Map<String, dynamic> toUpdateJson() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'color': color,
      'onSaveTime': onSaveTime,
      'onEndTime': onEndTime,
    };
  }
}
