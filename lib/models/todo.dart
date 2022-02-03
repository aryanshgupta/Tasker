import 'package:hive/hive.dart';
part 'todo.g.dart';
// flutter packages pub run build_runner build

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String task;
  @HiveField(1)
  final String detail;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final DateTime addedOn;
  @HiveField(4)
  final DateTime? modifiedOn;
  @HiveField(5)
  final bool completed;
  @HiveField(6)
  final DateTime? completedOn;
  @HiveField(7)
  final DateTime? startDateTime;
  @HiveField(8)
  final DateTime? endDateTime;

  TodoModel({
    required this.task,
    required this.detail,
    required this.category,
    required this.addedOn,
    this.modifiedOn,
    required this.completed,
    this.completedOn,
    this.startDateTime,
    this.endDateTime,
  });
}
