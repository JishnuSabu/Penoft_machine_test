class FullNameResponse {
  final String message;
  final String fullname;

  FullNameResponse({required this.message, required this.fullname});

  factory FullNameResponse.fromJson(Map<String, dynamic> json) {
    return FullNameResponse(
      message: json['message'] ?? '',
      fullname: json['fullname'] ?? '',
    );
  }
}
