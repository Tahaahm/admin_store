import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final double depth; // in meters
  final double width; // in meters
  final double height; // in meters
  final double weight; // in kilograms
  final double power; // in kilowatts
  final double price;
  final String currency;
  final String material;
  final String imageUrl;
  final String brand;
  final int stock;
  final List<String> description;
  final double volume; // in cubic meters
  final String supcategoryId;
  final String categoryId;
  final String brandId;

  ProductModel({
    required this.id,
    required this.title,
    required this.depth,
    required this.width,
    required this.height,
    required this.weight,
    required this.power,
    required this.price,
    required this.currency,
    required this.material,
    required this.imageUrl,
    required this.brand,
    required this.stock,
    required this.description,
    required this.volume,
    required this.supcategoryId,
    required this.categoryId,
    required this.brandId,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    return ProductModel(
      id: doc.id,
      title: doc['title'],
      depth: doc['depth'].toDouble(),
      width: doc['width'].toDouble(),
      height: doc['height'].toDouble(),
      weight: doc['weight'].toDouble(),
      power: doc['power'].toDouble(),
      price: doc['price'],
      currency: doc['currency'],
      material: doc['material'],
      imageUrl: doc['imageUrl'],
      brand: doc['brand'],
      stock: doc['stock'],
      description: List<String>.from(doc['description']),
      volume: doc['volume'].toDouble(),
      supcategoryId: doc['supcategoryId'], // Added supcategoryId
      categoryId: doc['categoryId'], // Added categoryId
      brandId: doc['brandId'], // Added brandId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'depth': depth,
      'width': width,
      'height': height,
      'weight': weight,
      'power': power,
      'price': price,
      'currency': currency,
      'material': material,
      'imageUrl': imageUrl,
      'brand': brand,
      'stock': stock,
      'description': description,
      'volume': volume,
      'supcategoryId': supcategoryId, // Added supcategoryId
      'categoryId': categoryId, // Added categoryId
      'brandId': brandId, // Added brandId
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'depth': depth,
      'width': width,
      'height': height,
      'weight': weight,
      'power': power,
      'price': price,
      'currency': currency,
      'material': material,
      'imageUrl': imageUrl,
      'brand': brand,
      'stock': stock,
      'description': description,
      'volume': volume,
      'supcategoryId': supcategoryId, // Added supcategoryId
      'categoryId': categoryId, // Added categoryId
      'brandId': brandId, // Added brandId
    };
  }
}
