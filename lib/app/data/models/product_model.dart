import 'package:flutter/material.dart';

class ProductModel {
  int? id;
  String? image;
  String? name;
  String? brand;
  String? category;
  int? quantity;
  double? price;
  double? oldPrice;
  double? rating;
  String? reviews;
  String? size;
  bool? isFavorite;
  String? description;
  List<Color>? availableColors;
  Color? selectedColor;
  int? discountPercent;
  String? tag;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.brand,
    this.category,
    this.quantity = 0,
    this.price,
    this.oldPrice,
    this.rating,
    this.reviews,
    this.size,
    this.isFavorite = false,
    this.description,
    this.availableColors,
    this.selectedColor,
    this.discountPercent,
    this.tag,
  });
}