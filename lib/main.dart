import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasker/functions/first_visit.dart';
import 'package:tasker/models/category.dart';
import 'package:tasker/models/todo.dart';
import 'package:tasker/screens/home.dart';
import 'package:tasker/screens/landing.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<CategoryModel>("categories");
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  bool seenApp = await firstVisit();
  runApp(MyApp(
    savedThemeMode: savedThemeMode,
    seen: seenApp,
  ));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool seen;
  const MyApp({
    required this.savedThemeMode,
    required this.seen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Poppins",
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: "Poppins",
      ),
      initial: this.savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (ThemeData theme, ThemeData darkTheme) => MaterialApp(
        title: 'Tasker',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: this.seen ? Home() : Landing(),
      ),
    );
  }
}
