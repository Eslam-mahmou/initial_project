import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:initial_project/core/routes/routes_generator.dart';
import 'package:initial_project/core/service/easy_loading_service.dart';

import 'core/di/injectable_initializer.dart';
import 'core/service/bloc_observer.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  ConfigLoading().showLoading();
  configureDependencies();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter  Demo',
      onGenerateRoute: RoutesGenerator.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),);
  }
}