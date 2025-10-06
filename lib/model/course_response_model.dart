class CourseResponseModel {
  final String message;
  final List<Course> data;

  CourseResponseModel({required this.message, required this.data});

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class Course {
  final String title;
  final String author;
  final String duration;
  final String price;
  final String originalPrice;
  final double rating;
  final int reviews;
  final String tag;
  final String image;

  Course({
    required this.title,
    required this.author,
    required this.duration,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.tag,
    required this.image,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      duration: json['duration'] ?? '',
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
      'author': author,
      'duration': duration,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviews': reviews,
      'tag': tag,
      'image': image,
    };
  }
}
