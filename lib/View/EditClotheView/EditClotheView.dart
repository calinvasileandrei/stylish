import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/Components/StylishAlertDialog.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/ScraperAPI/ScraperAPI.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:stylish/Utils/global.dart';
import 'package:stylish/View/CreateClotheView/Components/DropDownCategories.dart';
import 'package:stylish/View/CreateClotheView/Components/ProductImage.dart';
import 'package:stylish/View/CreateClotheView/Components/StylishFormInput.dart';
import 'package:stylish/View/CreateClotheView/Components/StylishLargeButton.dart';
import 'package:stylish/View/CreateClotheView/bloc/CreateClotheBloc.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';

class EditClotheView extends StatefulWidget {
  Clothe clothe;

  EditClotheView({Key key, this.clothe}) : super(key: key);

  @override
  _EditClotheViewState createState() => _EditClotheViewState(clothe);
}

class _EditClotheViewState extends State<EditClotheView> {
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _linkController;
  TextEditingController _imageController;
  String _image;
  bool _isLocalImage = false;
  String _currentType;
  CreateClotheBloc createClotheBloc = new CreateClotheBloc();
  Clothe clothe;
  bool isEdit = false;

  _EditClotheViewState(this.clothe);

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController = new TextEditingController(text: clothe.name);
      _priceController = new TextEditingController(text: clothe.price);
      _linkController = new TextEditingController(text: clothe.link);
      _image = clothe.image;
      _isLocalImage = clothe.isLocalImage;
      if(_isLocalImage){
        _imageController =new TextEditingController(text: "Local Image");
      }else{
        _imageController = new TextEditingController(text: clothe.image);
      }
      _currentType = clothe.category;

    });
  }

  void getImage() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      Uint8List bytes = image.readAsBytesSync();
      setState(() {
        _imageController.text = "Local Image";
        _image = base64Encode(bytes);
        _isLocalImage=true;
      });
    } catch (e) {
      setState(() {
        _imageController.text = "Error getting the image!";
      });
    }
  }

  void removeImage() async {
    setState(() {
      _imageController.text = "";
      _image = null;
      _isLocalImage = false;
    });
  }

  void updateClothe(BuildContext context, Clothe oldClothe) async {
    ClotheDao clotheDao = new ClotheDao();
    Clothe _clothe = new Clothe(_nameController.text, _priceController.text, _linkController.text, _image,_isLocalImage, _currentType);
    _clothe.id = oldClothe.id;
    if (_clothe != oldClothe) {
      await clotheDao.update(_clothe);
    }
    setState(() => isEdit = false);
    //update list on homeview
    BlocProvider.of<HomeBloc>(context).add(HomeEvent.Fetch);
  }

  void scrapeData() async {
    //Paste data from clipboard
    ClipboardData data = await Clipboard.getData('text/plain');
    setState(() {
      _linkController.text = "";
      _linkController.text = data.text;
    });
    String linkToScrape = _linkController.text;

    //create the scrapeApi
    final scrapeApi = new ScraperAPI();
    var response = await scrapeApi.scrapeWebsite(linkToScrape);

    //elaborate the result
    if (response["status"] == "Ok") {
      setState(() {
        _nameController.text = response["data"]["title"];
        _priceController.text = response["data"]["price"];
        _isLocalImage = false;
        _imageController.text = response["data"]["image"];
        _image = response["data"]["image"];
      });
    } else {
      setState(() {
        _linkController.text = response["msg"];
      });
    }
  }

  void deleteItem()async{
    ClotheDao clotheDao = new ClotheDao();
    if(clothe != null && clothe.id != null){
      await clotheDao.delete(clothe);
      BlocProvider.of<HomeBloc>(context).add(HomeEvent.Init);
    }

  }
  Widget alertDelete(){
    return StylishAlertDialog(
      title: "Delete Item",
      content: "Are you sure to delete this Item?",
      leftButton: new FlatButton(
        child: new Text("Delete Item",style: TextStyle(color: stylishTheme.accentColor ),),
        onPressed: () async {
          await deleteItem();
          await Navigator.pop(context);
          await Navigator.pop(context);
        },
      ),
      rightButton: new FlatButton(
        child: new Text("Cancel",style: TextStyle(color: stylishTheme.accentColor ),),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StylishSkeleton(
        subtitle: "Create your outfit",
        iconButton: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        actionButton: IconButton(
            icon: Icon(Icons.delete , color: Colors.black),
            onPressed: () => showDialog(context: context, builder: (context){
              return alertDelete();
            }) ),
        child: Container(
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Theme(
        //TODO: change this with a proper way, this is a fast way to set the input the round color border but not the best
        data: Theme.of(context).copyWith(primaryColor: Color(0xFFfa7b58)),
        child: Container(
            child: Padding(
                padding: EdgeInsets.only(left: 70.w, top: 0.h, right: 70.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProductImage(
                      image: _image,
                      isLocalImage: _isLocalImage,
                    ),
                    StylishFormInput(
                        name: "Link",
                        controller: _linkController,
                        disabled: !isEdit,
                        suffix: IconButton(
                          icon: Icon(Icons.content_paste),
                          onPressed: () => {scrapeData()},
                        )),
                    StylishFormInput(
                        name: "Name",
                        controller: _nameController,
                        disabled: !isEdit),
                    StylishFormInput(
                        name: "Price",
                        controller: _priceController,
                        disabled: !isEdit),
                    (_image == null || _image == '')
                        ? StylishFormInput(
                            name: "Image",
                            controller: _imageController,
                            disabled: !isEdit,
                            suffix: IconButton(
                              icon: Icon(Icons.image),
                              tooltip: 'Pick Image',
                              onPressed: !isEdit ? getImage : null,
                            ))
                        : StylishFormInput(
                            name: "Image",
                            controller: _imageController,
                            suffix: IconButton(
                                icon: Icon(Icons.delete),
                                tooltip: 'Remove Image',
                                onPressed: !isEdit ? removeImage : null),
                            disabled: !isEdit,
                          ),
                    DropDownCategories(
                      callback: (val) => setState(() => _currentType = val),
                      currentType: _currentType,
                    ),
                    !isEdit
                        ? StylishLargeButton(
                            buttonText: "Edit",
                            callback: () => setState(() => isEdit = true))
                        : StylishLargeButton(
                            buttonText: "Save Edits",
                            callback: () => updateClothe(context, clothe)),
                  ],
                ))));
  }
}
