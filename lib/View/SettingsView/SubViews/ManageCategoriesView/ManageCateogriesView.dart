import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Components/StylishBouncingButton.dart';
import 'package:stylish/DB/DataAccessObject/CategoryDao.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:stylish/Models/Category.dart';
import 'package:stylish/Utils/global.dart';

class ManageCategoriesView extends StatefulWidget {
  @override
  _ManageCategoriesViewState createState() => _ManageCategoriesViewState();
}

class _ManageCategoriesViewState extends State<ManageCategoriesView> {
  List<Category> categories;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Category>> loadData() async{
    if(categories == null){
      CategoryDao repository = new CategoryDao();
      return repository.getAllSortedByPosition();
    }else{
      return Future.value(categories);
    }
  }

  void reorderData(int oldindex, int newindex){
    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final item = categories.removeAt(oldindex);
      categories.insert(newindex, item);
    });
  }

  void savePosition()async{
    CategoryDao repository = new CategoryDao();
    for(int i=0;i<categories.length;i++) {
      final item = categories[i];
      item.position = i++;
      await repository.update(item);
    }
  }

  void sorting(){
    setState(() {
      categories.sort((a,b)=> a.name.compareTo(b.name));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StylishBouncingButton(buttonText:"Save",callback: ()=>savePosition(), width:(ScreenUtil().screenWidth * 0.7)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: StylishSkeleton(
        subtitle: "Manage Categories",
        iconButton: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actionButton: IconButton(
          icon: Icon(Icons.sort_by_alpha,color: Colors.black,),
          onPressed: sorting,
        ),
        child: Container(
          //TODO: check if with a long list be floating button creates problems
          margin: EdgeInsets.fromLTRB(12.w,48.h,12.w,48.h),
          child: FutureBuilder<List<Category>>(
            future: loadData(),
            builder: (context, snapshot) {
              if(snapshot!=null && snapshot.hasData){
                categories = snapshot.data;
               return ReorderableListView(
                onReorder: reorderData,
                children:<Widget> [
                  for(final item in categories)
                    Card(
                      shape: stylishCardShape ,
                      color: Colors.white,
                      key: ValueKey(item.name),
                      elevation: 3,
                      child: ListTile(
                        title: Text(item.name),
                        leading: Icon(Icons.sort,color: Colors.black,),
                      ),
                    ),
                ],
              );
              }else if(snapshot!=null && snapshot.hasError){
                return Center(child: Text("Error Loading data..."),);
              }else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
          ),
        )
      ),
    );
  }
}