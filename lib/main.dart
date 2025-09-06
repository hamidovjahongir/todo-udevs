import 'package:flutter/material.dart';
import 'package:todo/core/di/injection_container.dart';
import 'package:todo/features/app/application.dart';
import 'package:todo/features/home/data/datasources/local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  await LocalDatasource.init();
  runApp(const MainApp());
}