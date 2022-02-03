import 'package:flutter/material.dart';
import 'package:tasker/dialogs/components/dialog_heading.dart';
import 'package:tasker/dialogs/components/horizontal_pair_btn.dart';
import 'package:tasker/dialogs/components/input_field.dart';
import 'package:tasker/functions/default_category_view.dart';
import 'package:tasker/hive_boxes.dart';
import 'package:tasker/models/category.dart';

class ConfigList {
  final BuildContext context;
  final String title;
  final String? listName;

  ConfigList(this.context, this.title, {this.listName}) {
    TextEditingController _inputValue = TextEditingController();
    _inputValue.text = listName ?? "";
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
                keyboardType: TextInputType.text,
                maxLength: 50,
              ),
              SizedBox(height: 8.0),
              HorizontalPairBtn(
                confirmBtnTitle: "SAVE",
                onConfirmBtnPress: () {
                  if (_inputValue.text.trim().isNotEmpty) {
                    if (listName == null) {
                      categoriesBox.add(
                        CategoryModel(
                          name: _inputValue.text.trim().replaceAll("\n", " "),
                          todoList: [],
                          sortBy: "",
                          filterBy: "",
                          createdOn: DateTime.now(),
                          defaultView: false,
                        ),
                      );
                    } else {
                      categoriesBox.putAt(
                        defaultCategoryIndex(),
                        CategoryModel(
                          name: _inputValue.text.trim().replaceAll("\n", " "),
                          todoList: categoriesBox
                              .getAt(defaultCategoryIndex())!
                              .todoList,
                          sortBy: categoriesBox
                              .getAt(defaultCategoryIndex())!
                              .sortBy,
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
                    }

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
