import 'dart:io';

import 'package:stylish/Models/Clothe.dart';

class Category {
  int _id;
  String _name;
  List<int> _clothes;
  int _position;

  Category(
    this._name,
    this._clothes,
  );

  void set id(int id) {
    this._id = id;
  }

  void set position(int position) {
    this._position = position;
  }

  void addNewClothe(int clotheId) {
    _clothes.add(clotheId);
  }

  void removeClothe(int clotheId) {
    _clothes.remove(clotheId);
  }

  int get id => this._id;
  String get name => _name;
  List<int> get clothes => _clothes;
  int get position => this._position;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["name"] = name;
    map["clothes"] = clothes;
    map["position"] = position;

    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._clothes = new List<int>.from(map['clothes']);
    this._position = map['position'];
  }

  @override
  String toString() => 'Category(name: $_name, clothes: $_clothes)';

}
