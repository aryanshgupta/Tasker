import 'package:flutter/material.dart';
import 'package:tasker/dialogs/components/dialog_heading.dart';
import 'package:tasker/dialogs/components/horizontal_pair_btn.dart';
import 'package:tasker/dialogs/components/input_field.dart';
import 'package:tasker/functions/default_category_view.dart';
import 'package:tasker/hive_boxes.dart';
import 'package:tasker/models/category.dart';
import 'package:tasker/models/todo.dart';

class ConfigTodo {
  final BuildContext context;
  final String title;
  final String? todoTitle;
  final int? todoIndex;

  ConfigTodo(this.context, this.title, {this.todoTitle, this.todoIndex}) {
    TextEditingController _inputValue = TextEditingController();
    _inputValue.text = todoTitle ?? "";
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 8.0),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              DialogHeading(this.title),
              SizedBox(height: 8.0),
              InputField(
                controller: _inputValue,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 8.0),
              HorizontalPairBtn(
                confirmBtnTitle: "SAVE",
                onConfirmBtnPress: () {
                  if (_inputValue.text.trim().isNotEmpty &&
                      categoriesBox.getAt(defaultCategoryIndex()) != null) {
                    List<TodoModel> newTodoList =
                        categoriesBox.getAt(defaultCategoryIndex())!.todoList;

                    if (todoTitle != null && todoIndex != null) {
                      newTodoList[todoIndex!] = TodoModel(
                        task: _inputValue.text.trim(),
                        detail: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .detail,
                        category: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .category,
                        addedOn: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .addedOn,
                        modifiedOn: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .modifiedOn,
                        completed: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .completed,
                        completedOn: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .completedOn,
                        startDateTime: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .startDateTime,
                        endDateTime: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .todoList[todoIndex!]
                            .endDateTime,
                      );
                    } else {
                      newTodoList.add(
                        TodoModel(
                          task: _inputValue.text.trim(),
                          detail: "",
                          category:
                              categoriesBox.getAt(defaultCategoryIndex())!.name,
                          addedOn: DateTime.now(),
                          completed: false,
                        ),
                      );
                    }

                    categoriesBox.putAt(
                      defaultCategoryIndex(),
                      CategoryModel(
                        name: categoriesBox.getAt(defaultCategoryIndex())!.name,
                        todoList: newTodoList,
                        sortBy:
                            categoriesBox.getAt(defaultCategoryIndex())!.sortBy,
                        filterBy: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .filterBy,
                        createdOn: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .createdOn,
                        defaultView: categoriesBox
                            .getAt(defaultCategoryIndex())!
                            .defaultView,
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
