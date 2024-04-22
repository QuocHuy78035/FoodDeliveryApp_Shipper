
class CategoryResponse {
  String? message;
  int? status;
  List<Category>? metadata;

  CategoryResponse({
     this.message,
     this.status,
     this.metadata,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    message: json['message'],
    status: json['status'],
    metadata: List<Category>.from(json['metadata'].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'status': status,
    'metadata': List<dynamic>.from(metadata!.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['_id'],
    name: json['name'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'image': image,
  };
}