import 'dart:developer' as dv;
import 'package:flutter/material.dart';
import 'package:stylish/DB/DataAccessObject/ClotheDao.dart';
import 'package:stylish/Models/Clothe.dart';
import 'package:stylish/Utils/StylishSkeleton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker_modern/image_picker_modern.dart';



class CreateClotheView extends StatefulWidget {
  CreateClotheView({Key key}) : super(key: key);

  @override
  _CreateClotheViewState createState() => _CreateClotheViewState();
}

class _CreateClotheViewState extends State<CreateClotheView> {
  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _linkController;
  TextEditingController _imageController;
  String _image;
  List _categoriesTypes = ["Hat", "T-shirt/Vests", "Trousers", "Shoes", "Accessories"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentType;
  Clothe newClothe = new Clothe("", "", "", "", "", "");

  //TODO: implement logic for getting the data from db sembast
  List<String> categories;

  @override
  void initState() {
    super.initState();
    //_dropDownMenuItems = getDropDownMenuItems();
    _nameController = new TextEditingController(text: newClothe.name);
    _priceController = new TextEditingController(text: newClothe.price);
    _linkController = new TextEditingController(text: newClothe.link);
    _imageController = new TextEditingController(text: newClothe.image);
    //_currentType = _dropDownMenuItems[0].value;
  }


  List<DropdownMenuItem<String>> getDropDownMenuItems(categories) {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in categories) {
      items.add(new DropdownMenuItem(value: type, child: new Text(type)));
    }
    return items;
  }

  void changedDropDownItem(String selectedType) {
    setState(() {
      _currentType = selectedType;
    });
  }

  void getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Uint8List bytes = image.readAsBytesSync();
    setState(() {
      _image = base64Encode(bytes);
    });
  }

  void removeImage() async {
    setState(() {
      _image = null;
    });
  }

  void createClothe(BuildContext context) async{
    ClotheDao clotheDao = new ClotheDao();
    Clothe clothe = new Clothe(_nameController.text, _priceController.text, _linkController.text, _imageController.text, _image, _currentType);
    await clotheDao.insert(clothe);
    Navigator.pop(context);
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
                  _buildProductImage(),
                  _formInput("Link", _linkController,
                      suffix: IconButton(
                        icon: Icon(Icons.content_paste),
                        onPressed: () => {},
                      )),
                  _formInput("Name", _nameController),
                  _formInput("Price", _priceController),
                  (_image == null || _image == '')
                      ? _formInput("Image", _imageController,
                      suffix: IconButton(
                        icon: Icon(Icons.image),
                        tooltip: 'Pick Image',
                        onPressed: getImage,
                      ))
                      : _formInput("Image", _imageController,
                      suffix: IconButton(
                          icon: Icon(Icons.image),
                          tooltip: 'Pick Image',
                          onPressed: removeImage)),
                  Container(
                    width: ScreenUtil().screenWidth * 0.9,
                    padding: new EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 48.h),
                    child: Container(
                      padding: new EdgeInsets.only(left: 50.w, right: 50.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 3.w),
                      ),
                      child: DropdownButton<String>(
                        hint: Text("Select a type"),
                        value: _currentType,
                        items: getDropDownMenuItems(categories),
                        isExpanded: true,
                        onChanged: changedDropDownItem,
                      ),
                    ),
                  ),
                  _buildCreateButton("Create"),
                ],
              )))
    );
  }

  Widget _formInput(_name, _controller, {Widget suffix = null}) {
    return Container(
        width: ScreenUtil().screenWidth * 0.9,
        padding: new EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 48.h),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              labelText: _name,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(50.w, 37.h, 50.w, 37.h),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: suffix),
        ));
  }

  Widget _buildProductImage() {
    return SizedBox(
        width: ScreenUtil().setWidth(400),
        child: Container(
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(9.0),
              child: _image == null || _image == ""
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/logo_white512.png',
                      image: _imageController.text,
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.contain,
                    )
                  : new Image.memory(base64Decode(_image)),
            ),
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(4.0, 10.0),
                ),
              ],
            )));
  }

  Widget _buildCreateButton(floatingButtonText) {
    return Container(
      width: ScreenUtil().screenWidth * 0.95,
      height: 140.h,
      margin: EdgeInsets.only(top: 100.h),
      decoration: BoxDecoration(
          color: Color(0xFFfa7b58),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFf78a6c).withOpacity(.6),
                offset: Offset(0.0, 10.0),
                blurRadius: 10.0)
          ]),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(),
        child: Text(floatingButtonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 72.sp,
                fontWeight: FontWeight.bold)),
        onPressed: ()=> createClothe(context),
      ),
    );
  }
}
