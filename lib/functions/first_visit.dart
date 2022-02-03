import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasker/hive_boxes.dart';
import 'package:tasker/models/category.dart';

Future<bool> firstVisit() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _seen = (prefs.getBool('seen') ?? false);

  if (!_seen) {
    await prefs.setBool('seen', true);
    if (categoriesBox.isEmpty) {
      categoriesBox.add(
        CategoryModel(
          name: "My Tasks",
          todoList: [],
          sortBy: "",
          filterBy: "",
          createdOn: DateTime.now(),
          defaultView: true,
        ),
      );
    }
  }

  return _seen;
}
