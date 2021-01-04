import 'dart:io';

class Clothe {
  int _id;
  String _name;
  String _price;
  String _link;
  String _image;
  String _category;
  String _imageFile;

  Clothe(
    this._name,
    this._price,
    this._link,
    this._image,
    this._imageFile,
    this._category,
  );

  void set id(int id) {
    this._id = id;
  }

  Clothe.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._price = obj['price'];
    this._link = obj['link'];
    this._image = obj['image'];
    this._imageFile = obj['imageFile'];
    this._category = obj['category'];
  }

  int get id => this._id;
  String get name => _name;
  String get price => _price;
  String get link => _link;
  String get image => _image;
  String get imageFile => _imageFile;
  String get category => _category;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["name"] = name;
    map["price"] = price;
    map["link"] = link;
    map["image"] = image;
    map["imageFile"] = imageFile;
    map["category"] = category;

    return map;
  }

  Clothe.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._price = map['price'];
    this._link = map['link'];
    this._image = map['image'];
    this._imageFile = map['imageFile'];
    this._category = map['category'];
  }

  @override
  String toString() => 'Clothe(id: $_id, name: $_name, price: $_price, link: $_link, category: $_category)';

}
