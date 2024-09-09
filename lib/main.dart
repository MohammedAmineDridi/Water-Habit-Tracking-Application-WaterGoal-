import 'package:flutter/material.dart';
import 'package:watergoal/logic_presentation_layer/getStarted.dart';
import 'core/routing/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
      title:'Water Goal Application',
      home: Getstarted(),
    );
  }
}
