import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasker/dialogs/config_list.dart';
import 'package:tasker/dialogs/config_todo.dart';
import 'package:tasker/dialogs/confirmation_dialog.dart';
import 'package:tasker/dialogs/message_dialog.dart';
import 'package:tasker/dialogs/theme_changer.dart';
import 'package:tasker/functions/default_category_view.dart';
import 'package:tasker/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasker/models/category.dart';
import 'package:tasker/models/todo.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // ***** change app theme *****
        leading: IconButton(
          onPressed: () {
            AdaptiveThemeMode thmode = AdaptiveTheme.of(context).mode;
            ThemeChange(context, thmode);
          },
          icon: Icon(
            Icons.brightness_4_rounded,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          tooltip: "Theme",
          splashRadius: 22.0,
        ),
        title: Text(
          "tasker",
          style: TextStyle(
            fontFamily: "TTFirsNeue",
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontSize: 22.0,
          ),
        ),
        actions: [
          // ***** menu options *****
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade300
                  : Colors.grey.shade800,
              size: 25.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            tooltip: "Menu",
            splashRadius: 22.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
            onSelected: (dynamic value) {
              // ***** when click on rename list option *****
              if (value == 1) {
                ConfigList(
                  context,
                  "Rename list",
                  listName: categoriesBox.getAt(defaultCategoryIndex())!.name,
                );
              }
              // ***** when click on delete list option *****
              else if (value == 2) {
                if (categoriesBox.keys.length > 1) {
                  ConfirmationDialog(
                    context,
                    title: "Deleting a List",
                    message:
                        "Are you sure you want to delete this list and all its tasks?",
                    confirmBtnTitle: "Delete",
                    onConfirmBtnPress: () {
                      categoriesBox.deleteAt(defaultCategoryIndex());
                      categoriesBox.putAt(
                        0,
                        CategoryModel(
                          name: categoriesBox.getAt(0)!.name,
                          todoList: categoriesBox.getAt(0)!.todoList,
                          sortBy: categoriesBox.getAt(0)!.sortBy,
                          filterBy: categoriesBox.getAt(0)!.filterBy,
                          createdOn: categoriesBox.getAt(0)!.createdOn,
                          defaultView: true,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                } else {
                  MessageDialog(
                    context,
                    title: "Deleting a default list",
                    message:
                        "This list is your default list and can't be deleted.",
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              // ***** rename the list option *****
              PopupMenuItem(
                value: 1,
                child: Wrap(
                  children: [
                    Icon(
                      Icons.drive_file_rename_outline_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      size: 22.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Rename list",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              // ***** delete the list option *****
              PopupMenuItem(
                value: 2,
                child: Wrap(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      size: 22.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Delete list",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        // ***** Category List and Add new List *****
        bottom: PreferredSize(
          child: Container(
            height: 50.0,
            child: Row(
              children: [
                SizedBox(width: 3.0),
                // ***** Category List *****
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: categoriesBox.listenable(),
                      builder: (context, value, child) {
                        return SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesBox.values.toList().map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: TextButton(
                                  // ***** change the list view when click on specific list items *****
                                  onPressed: () {
                                    categoriesBox.keys.forEach((element) {
                                      categoriesBox.put(
                                        element,
                                        CategoryModel(
                                          name:
                                              categoriesBox.get(element)!.name,
                                          todoList: categoriesBox
                                              .get(element)!
                                              .todoList,
                                          sortBy: categoriesBox
                                              .get(element)!
                                              .sortBy,
                                          filterBy: categoriesBox
                                              .get(element)!
                                              .filterBy,
                                          createdOn: categoriesBox
                                              .get(element)!
                                              .createdOn,
                                          defaultView:
                                              categoriesBox.get(element)! ==
                                                      item
                                                  ? true
                                                  : false,
                                        ),
                                      );
                                    });
                                  },
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      item.defaultView
                                          ? Colors.blue
                                          : Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.blue.shade200
                                              : Colors.blue.shade100,
                                    ),
                                    foregroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                      Colors.blue.shade500,
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                ),
                SizedBox(width: 8.0),
                // ***** Add new List *****
                TextButton.icon(
                  onPressed: () {
                    ConfigList(context, "Create a new list");
                  },
                  icon: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                    size: 16.0,
                  ),
                  label: Text(
                    "New List",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
                    overlayColor: MaterialStateProperty.all(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white10
                          : Colors.black12,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50.0),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: categoriesBox.listenable(),
        builder: (context, value, child) {
          CategoryModel categoryDetail = categoriesBox.values
              .where((element) => element.defaultView)
              .first;

          return categoryDetail.todoList.isEmpty
              ? // ***** If no todo list is found *****
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/add_notes.svg",
                        width: MediaQuery.of(context).size.width * 0.75,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "No tasks here yet",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        "Start adding tasks by tapping the \"+\" button",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade500
                              : Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              :
              // ***** if todo list exist *****
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categoryDetail.todoList.length,
                  itemBuilder: (context, index) {
                    TodoModel todo = categoryDetail.todoList[index];

                    return Dismissible(
                      key: Key("Dismissible: $index"),
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Text(
                                " Delete",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              Text(
                                " Delete",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      // ***** dismiss the todo to delete from list *****
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart ||
                            direction == DismissDirection.startToEnd) {
                          List<TodoModel> newTodoList = categoryDetail.todoList;

                          newTodoList.remove(todo);

                          categoriesBox.putAt(
                            defaultCategoryIndex(),
                            CategoryModel(
                              name: categoriesBox
                                  .getAt(defaultCategoryIndex())!
                                  .name,
                              todoList: newTodoList,
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

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task deleted"),
                              action: SnackBarAction(
                                label: "Undo",
                                onPressed: () {
                                  newTodoList.insert(index, todo);

                                  categoriesBox.putAt(
                                    defaultCategoryIndex(),
                                    CategoryModel(
                                      name: categoriesBox
                                          .getAt(defaultCategoryIndex())!
                                          .name,
                                      todoList: newTodoList,
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
                                },
                              ),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        onTap: () {
                          ConfigTodo(
                            context,
                            "Edit task",
                            todoIndex: index,
                            todoTitle: todo.task,
                          );
                        },
                        leading: GestureDetector(
                          child: todo.completed
                              ? SvgPicture.asset("assets/svg/done_on.svg")
                              : SvgPicture.asset(
                                  "assets/svg/done_off.svg",
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                          // ***** mark todo as completed or uncompleted in list *****
                          onTap: () {
                            List<TodoModel> newTodoList =
                                categoryDetail.todoList;

                            newTodoList.remove(todo);

                            newTodoList.insert(
                              index,
                              TodoModel(
                                task: todo.task,
                                detail: todo.detail,
                                category: todo.category,
                                addedOn: todo.addedOn,
                                modifiedOn: todo.modifiedOn,
                                completed: !todo.completed,
                                completedOn:
                                    todo.completed ? DateTime.now() : null,
                              ),
                            );

                            categoriesBox.putAt(
                              defaultCategoryIndex(),
                              CategoryModel(
                                name: categoriesBox
                                    .getAt(defaultCategoryIndex())!
                                    .name,
                                todoList: newTodoList,
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
                          },
                        ),
                        title: Text(
                          todo.task,
                          style: TextStyle(
                            fontSize: 18.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? todo.completed
                                        ? Colors.grey.shade400
                                        : Colors.white
                                    : todo.completed
                                        ? Colors.grey.shade700
                                        : Colors.black,
                            decoration: todo.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      // ***** add todo in list *****
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          ConfigTodo(context, "Add a new task");
        },
        tooltip: "Add Todo",
      ),
    );
  }
}
