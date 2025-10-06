class SubjectResponseModel {
  final String message;
  final List<Subject> data;

  SubjectResponseModel({required this.message, required this.data});

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) {
    return SubjectResponseModel(
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Subject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data.map((e) => e.toJson()).toList()};
  }
}

class Subject {
  final String subject;
  final String icon;
  final String mainColor;
  final String gradientColor;

  Subject({
    required this.subject,
    required this.icon,
    required this.mainColor,
    required this.gradientColor,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject: json['subject'] ?? '',
      icon: json['icon'] ?? '',
      mainColor: json['main-color'] ?? '#000000',
      gradientColor: json['gradient-color'] ?? '#000000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'icon': icon,
      'main-color': mainColor,
      'gradient-color': gradientColor,
    };
  }
}
