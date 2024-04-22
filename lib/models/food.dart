
import 'package:ddnangcao_project/models/category.dart';

class Food {
  final String id;
  final String name;
  final String image;
  final Category category;
  final Store store;
  final int price;
  final String rating;
  final int left;
  final int sold;

  Food({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.store,
    required this.price,
    required this.rating,
    required this.left,
    required this.sold,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      category: Category.fromJson(json['category']),
      store: Store.fromJson(json['store']),
      price: json['price'],
      rating: json['rating'],
      left: json['left'],
      sold: json['sold'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
    'category': category.toJson(),
    'store': store.toJson(),
    'price': price,
    'rating': rating,
    'left': left,
    'sold': sold,
  };
}

class Store {
  final String id;
  final String name;
  final String address;
  final int rating;
  final String timeOpen;
  final String timeClose;
  final String image;
  final double longitude;
  final double latitude;
  final String vendor;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.timeOpen,
    required this.timeClose,
    required this.image,
    required this.longitude,
    required this.latitude,
    required this.vendor,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      rating: json['rating'],
      timeOpen: json['time_open'],
      timeClose: json['time_close'],
      image: json['image'],
      longitude: json['longtitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      vendor: json['vendor'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'address': address,
    'rating': rating,
    'time_open': timeOpen,
    'time_close': timeClose,
    'image': image,
    'longtitude': longitude,
    'latitude': latitude,
    'vendor': vendor,
  };
}