import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/ScraperAPI/ScraperAPI.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:stylish/View/CreateClotheView/Components/DropDownCategories.dart';
import 'package:stylish/View/CreateClotheView/Components/ProductImage.dart';
import 'package:stylish/View/CreateClotheView/Components/StylishFormInput.dart';
import 'package:stylish/View/CreateClotheView/Components/StylishLargeButton.dart';
import 'package:stylish/View/CreateClotheView/bloc/CreateClotheBloc.dart';
import 'package:stylish/View/HomeView/bloc/HomeBloc.dart';
import 'package:stylish/main.dart';

//TODO Convert from CreateClotheView to EditClotheView

class EditClotheView extends StatefulWidget {
  Clothe clothe;
  EditClotheView({Key key,this.clothe}) : super(key: key);

  @override
  _EditClotheViewState createState() => _EditClotheViewState(clothe);
}

class _EditClotheViewState extends State<EditClotheView> {
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _linkController;
  TextEditingController _imageController;
  String _image;
  String _currentType;
  CreateClotheBloc createClotheBloc = new CreateClotheBloc();
  Clothe clothe;
  bool isEdit=false;
  _EditClotheViewState(this.clothe);


  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController = new TextEditingController(text: clothe.name);
      _priceController = new TextEditingController(text: clothe.price);
      _linkController = new TextEditingController(text: clothe.link);
      _imageController = new TextEditingController(text: clothe.image);
      _currentType=clothe.category;
    });
  }

  void getImage() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      Uint8List bytes = image.readAsBytesSync();
      setState(() {
        _imageController.text = "Local Image";
        _image = base64Encode(bytes);
      });
    }catch(e){
      setState(() {
        _imageController.text="Error getting the image!";
      });
    }
  }

  void removeImage() async {
    setState(() {
      _imageController.text = "";
      _image = null;
    });
  }

  void updateClothe(BuildContext context,Clothe oldClothe) async{
    ClotheDao clotheDao = new ClotheDao();
    Clothe _clothe = new Clothe(_nameController.text, _priceController.text, _linkController.text, _imageController.text, _image, _currentType);
    _clothe.id =oldClothe.id;
    if(_clothe!=oldClothe){
      await clotheDao.update(_clothe);
    }
    setState(()=> isEdit=false);
  }

  void scrapeData() async{
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
    if(response["status"] == "Ok"){
      setState(() {
        _nameController.text = response["data"]["title"];
        _priceController.text = response["data"]["price"];
        _imageController.text = response["data"]["image"];
        _image = null;
      });
    }else{
      setState(() {
        _linkController.text = response["msg"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StylishSkeleton(
        subtitle: "Create your outfit",
        iconButton: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        child: Container(
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Theme(
        data: Theme.of(context).copyWith(
            primaryColor: Color(
                0xFFfa7b58)), //TODO: change this with a proper way, this is a fast way to set the input the round color border but not the best
        child:Container(
            child: Padding(
                padding: EdgeInsets.only(left: 70.w, top: 0.h, right: 70.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ProductImage(image: _image,imageText: _imageController.text,),
                    StylishFormInput(name:"Link",controller: _linkController, disabled: !isEdit,
                        suffix: IconButton(
                          icon: Icon(Icons.content_paste),
                          onPressed: () => {scrapeData()},
                        )),
                    StylishFormInput(name:"Name",controller: _nameController, disabled: !isEdit),
                    StylishFormInput(name:"Price",controller:_priceController, disabled: !isEdit),
                    (_image == null || _image == '')
                        ? StylishFormInput(name:"Image", controller: _imageController, disabled: !isEdit,
                        suffix: IconButton(
                          icon: Icon(Icons.image),
                          tooltip: 'Pick Image',
                          onPressed: !isEdit? getImage:null,
                        ))
                        : StylishFormInput(name:"Image", controller: _imageController,
                      suffix: IconButton(
                          icon: Icon(Icons.delete),
                          tooltip: 'Remove Image',
                          onPressed: !isEdit? removeImage:null), disabled: !isEdit,),
                    DropDownCategories(callback: (val) => setState(() => _currentType = val),currentType: _currentType,),
                    !isEdit? StylishLargeButton(buttonText: "Edit",callback: ()=>setState(()=>isEdit=true)):
                        StylishLargeButton(buttonText: "Save Edits",callback: ()=>updateClothe(context, clothe)),

                  ],
                )))
    );
  }

}
