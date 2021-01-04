import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:stylish/Models/Clothe.dart';

class CategoryClothes {
  String category;
  List<Clothe> clothes;

  CategoryClothes({
    this.category,
    this.clothes,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'clothes': clothes?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CategoryClothes.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryClothes(
      category: map['category'],
      clothes: List<Clothe>.from(map['clothes']?.map((x) => Clothe.fromMap(x))),
    );
  }

  @override
  String toString() => 'Home(category: $category, clothes: $clothes)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryClothes &&
        o.category == category &&
        listEquals(o.clothes, clothes);
  }
}
