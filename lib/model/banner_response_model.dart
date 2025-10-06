class BannerResponseModel {
  final String message;
  final String data;

  BannerResponseModel({required this.message, required this.data});

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerResponseModel(
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data};
  }
}
