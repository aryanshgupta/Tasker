import 'package:hive/hive.dart';
import 'package:tasker/models/todo.dart';
part 'category.g.dart';
// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<TodoModel> todoList;
  @HiveField(2)
  final String sortBy;
  @HiveField(3)
  final String filterBy;
  @HiveField(4)
  final DateTime createdOn;
  @HiveField(5)
  final bool defaultView;

  CategoryModel({
    required this.name,
    required this.todoList,
    required this.sortBy,
    required this.filterBy,
    required this.createdOn,
    required this.defaultView,
  });
}
