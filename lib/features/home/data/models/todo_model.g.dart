// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoModelImpl _$$TodoModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      color: json['color'] as String?,
      time: json['time'] as String?,
      onSaveTime: json['onSaveTime'] as String?,
      onEndTime: json['onEndTime'] as String?,
      addTime: json['addTime'] as String?,
    );

Map<String, dynamic> _$$TodoModelImplToJson(_$TodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'color': instance.color,
      'time': instance.time,
      'onSaveTime': instance.onSaveTime,
      'onEndTime': instance.onEndTime,
      'addTime': instance.addTime,
    };
