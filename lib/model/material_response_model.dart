class MaterialResponseModel {
  final String message;
  final List<MaterialItem> data;

  MaterialResponseModel({required this.message, required this.data});

  factory MaterialResponseModel.fromJson(Map<String, dynamic> json) {
    return MaterialResponseModel(
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => MaterialItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class MaterialItem {
  final String title;
  final String brand;
  final String price;
  final String originalPrice;
  final double rating;
  final int reviews;
  final String tag;
  final String image;

  MaterialItem({
    required this.title,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.tag,
    required this.image,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      price: json['price'] ?? '',
      originalPrice: json['originalPrice'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
      tag: json['tag'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'brand': brand,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviews': reviews,
      'tag': tag,
      'image': image,
    };
  }
}
