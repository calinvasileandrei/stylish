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
import 'package:stylish/View/CreateClotheView/Components/ProductImage.dart';
import 'package:stylish/Components/StylishFormInput.dart';
import 'package:stylish/Components/StylishLargeButton.dart';
import 'package:stylish/View/CreateClotheView/bloc/CreateClotheBloc.dart';
import 'package:stylish/main.dart';
import 'Components/DropDownCategories.dart';


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
  bool _isLocalImage=false;
  String _currentType;
  Clothe newClothe = new Clothe("", "", "", "", false,"");
  CreateClotheBloc createClotheBloc = new CreateClotheBloc();

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: newClothe.name);
    _priceController = new TextEditingController(text: newClothe.price);
    _linkController = new TextEditingController(text: newClothe.link);
    _imageController = new TextEditingController(text: newClothe.image);
  }

  void getImage() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      Uint8List bytes = image.readAsBytesSync();
      setState(() {
        _imageController.text = "Local Image";
        _image = base64Encode(bytes);
        _isLocalImage = true;
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
      _isLocalImage = false;
    });
  }

  void createClothe(BuildContext context) async{
    ClotheDao clotheDao = new ClotheDao();
    Clothe clothe = new Clothe(_nameController.text, _priceController.text, _linkController.text, _image,_isLocalImage, _currentType);
    await clotheDao.insert(clothe);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TabControllerApp()),
          (Route<dynamic> route) => false,
    );
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
        _isLocalImage = false;
        _imageController.text = response["data"]["image"];
        _image = response["data"]["image"];
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
                  ProductImage(image: _image,
                    isLocalImage: _isLocalImage,
                  ),
                  StylishFormInput(name:"Link",controller: _linkController,
                      suffix: IconButton(
                        icon: Icon(Icons.content_paste),
                        onPressed: () => {scrapeData()},
                      )),
                  StylishFormInput(name:"Name",controller: _nameController),
                  StylishFormInput(name:"Price",controller:_priceController),
                  (_image == null || _image == '')
                      ? StylishFormInput(name:"Image", controller: _imageController,
                      suffix: IconButton(
                        icon: Icon(Icons.image),
                        tooltip: 'Pick Image',
                        onPressed: getImage,
                      ))
                      : StylishFormInput(name:"Image", controller: _imageController,
                      suffix: IconButton(
                          icon: Icon(Icons.delete),
                          tooltip: 'Remove Image',
                          onPressed: removeImage), disabled: true,),
                  DropDownCategories(callback:  (val) => setState(() => _currentType = val),currentType: _currentType,),
                  StylishLargeButton(buttonText: "Create",callback: ()=>createClothe(context))

                ],
              )))
    );
  }

}
