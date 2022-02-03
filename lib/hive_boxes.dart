import 'package:hive/hive.dart';
import 'package:tasker/models/category.dart';

final Box<CategoryModel> categoriesBox = Hive.box<CategoryModel>("categories");
