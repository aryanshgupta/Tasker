import 'package:tasker/hive_boxes.dart';

int defaultCategoryIndex() {
  late int index;
  for (int i = 0; i < categoriesBox.values.length; i++) {
    if (categoriesBox.values.toList()[i].defaultView) {
      index = i;
    }
  }
  return index;
}
