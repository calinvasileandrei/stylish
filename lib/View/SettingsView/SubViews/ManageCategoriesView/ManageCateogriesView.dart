import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stylish/Components/StylishBouncingButton.dart';
import 'package:stylish/Components/StylishCircularButton.dart';
import 'package:stylish/Components/StylishInputAlertDialog.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Utils/global.dart';

class ManageCategoriesView extends StatefulWidget {
  @override
  _ManageCategoriesViewState createState() => _ManageCategoriesViewState();
}

enum EventsCategories { Init, Load, Reload }

class _ManageCategoriesViewState extends State<ManageCategoriesView> {
  List<Category> categories;
  TextEditingController _categoryNameController;
  CategoryDao repository = new CategoryDao();

  @override
  void initState() {
    super.initState();
    setState(() {
      _categoryNameController = new TextEditingController(text: "");
    });
  }

  Future<List<Category>> loadData(event) async {
    if (event == EventsCategories.Init && categories == null) {
      CategoryDao repository = new CategoryDao();
      return repository.getAllSortedByPosition();
    } else if (event == EventsCategories.Load ||
        (event == EventsCategories.Init && categories != null)) {
      return Future.value(categories);
    } else if (event == EventsCategories.Reload) {
      CategoryDao repository = new CategoryDao();
      return repository.getAllSortedByPosition();
    }
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final item = categories.removeAt(oldindex);
      categories.insert(newindex, item);
    });
  }

  void savePosition() async {
    CategoryDao repository = new CategoryDao();
    for (int i = 0; i < categories.length; i++) {
      var pos = i;
      final item = categories[pos];
      item.position = pos++;
      await repository.update(item);
    }
  }

  void sorting() {
    setState(() {
      categories.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  Widget _buildCreateCategory(_type, _method, _text) {
    return StylishInputAlertDialog(
      title: "$_type Category",
      text: _text,
      textController: _categoryNameController,
      rightButton: new FlatButton(
        child: new Text(
          _type,
          style: TextStyle(color: stylishTheme.accentColor),
        ),
        onPressed: () async {
          await _method();
          await Navigator.pop(context);
        },
      ),
      leftButton: new FlatButton(
        child: new Text(
          "Cancel",
          style: TextStyle(color: stylishTheme.accentColor),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    ;
  }

  void createCategory() async {
    Category newCategory =
        new Category(_categoryNameController.text, new List<int>());
    final categoryId = await repository.insert(newCategory);
    newCategory.id = categoryId;
    setState(() {
      categories.add(newCategory);
    });
  }

  void deleteCategory(Category _category) async {
    await repository.delete(_category);
    setState(() {
      categories.remove(_category);
    });
  }

  void updateCategory(Category _category) async {
    var itemIndex = categories.indexOf(_category);

    _category.name = _categoryNameController.text;

    await repository.update(_category);
    setState(() {
      categories[itemIndex] = _category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StylishSkeleton(
          subtitle: "Manage Categories",
          iconButton: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actionButton: IconButton(
              icon: Icon(
                Icons.sort_by_alpha,
                color: Colors.black,
              ),
              onPressed: ()=> sorting() //sorting,
              ),
          child: Container(
            //TODO: check if with a long list be floating button creates problems
            margin: EdgeInsets.fromLTRB(12.w, 48.h, 12.w, 48.h),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Category>>(
                      future: loadData(EventsCategories.Init),
                      builder: (context, snapshot) {
                        if (snapshot != null && snapshot.hasData) {
                          categories = snapshot.data;
                          return ReorderableListView(
                            onReorder: reorderData,
                            children: <Widget>[
                              for (final item in categories)
                                Card(
                                  shape: stylishCardShape,
                                  color: Colors.white,
                                  key: ValueKey(item.name),
                                  elevation: 3,
                                  child: new Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.25,
                                    actions: <Widget>[
                                      new IconSlideAction(
                                          caption: 'Edit',
                                          color: Colors.indigo,
                                          icon: Icons.edit,
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return _buildCreateCategory(
                                                    "Update",
                                                    () => updateCategory(item),
                                                    "Category name");
                                              })),
                                    ],
                                    secondaryActions: <Widget>[
                                      new IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () => deleteCategory(item),
                                      ),
                                    ],
                                    child: ListTile(
                                      title: Text(item.name),
                                      leading: Icon(
                                        Icons.sort,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else if (snapshot != null && snapshot.hasError) {
                          return Center(
                            child: Text("Error Loading data..."),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.bottomRight,
                        child: StylishBouncingButton(
                            buttonText: "Save",
                            callback: () => savePosition(),
                            width: (ScreenUtil().screenWidth * 0.6))
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StylishCircularButton(icon: Icons.add,callBack: ()=> showDialog(
                              context: context,
                              builder: (context) {
                                return _buildCreateCategory(
                                    "Create", () => createCategory(), "Category Name");
                              }),),
                        )
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
