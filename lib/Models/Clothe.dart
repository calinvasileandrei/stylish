import 'dart:io';

class Clothe{
  int _ID;
  String _Name;
  String _Price;
  String _Link;
  String _Image;
  String _Type;
  String _ImageFile;


  Clothe(this._Name,this._Price,this._Link,this._Image,this._ImageFile,this._Type,);

  Clothe.map(dynamic obj) {
    this._ID = obj['ID'];
    this._Name = obj['Name'];
    this._Price = obj['Price'];
    this._Link = obj['Link'];
    this._Image = obj['Image'];
    this._ImageFile = obj['ImageFile'];
    this._Type = obj['Type'];


  }

  int get ID => this._ID;
  String get Name => _Name;
  String get Price => _Price;
  String get Link => _Link;
  String get Image => _Image;
  String get ImageFile => _ImageFile;
  String get Type => _Type;



  Map<String, dynamic> toMap() {
    var map =new  Map<String, dynamic>();
    if(ID != null){
      map["ID"] = ID;
    }
    map["Name"] = Name;
    map["Price"] = Price;
    map["Link"] = Link;
    map["Image"] = Image;
    map["ImageFile"] = ImageFile;
    map["Type"] = Type;


    return map;
  }

  Clothe.fromMap(Map<String, dynamic> map){
    this._ID = map['ID'];
    this._Name = map['Name'];
    this._Price = map['Price'];
    this._Link = map['Link'];
    this._Image = map['Image'];
    this._ImageFile = map['ImageFile'];
    this._Type = map['Type'];

  }




}