import 'dart:convert';
import 'package:flutter_application_1/model/banner_response_model.dart';
import 'package:flutter_application_1/model/course_response_model.dart';
import 'package:flutter_application_1/model/fullname_response_model.dart';
import 'package:flutter_application_1/model/material_response_model.dart';
import 'package:flutter_application_1/model/subject_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String baseUrl;
  String? token;
  ApiService({required this.baseUrl});

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtToken');
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool requiresAuth = false,
  }) async {
    await _loadToken();

    final headers = {'Content-Type': 'application/json'};
    if (requiresAuth && token != null && token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.post(
      Uri.parse('$baseUrl/user$endpoint'),
      headers: headers,
      body: json.encode(body),
    );

    final data = json.decode(response.body);

    if (data.containsKey('error') && data['error'] != null) {
      throw Exception(data['error']);
    }

    return data;
  }

  Future<Map<String, dynamic>> sendOtp(String email) async {
    return await post('/send-otp', {'email': email});
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    return await post('/verify-otp', {'email': email, 'otp': otp});
  }

  Future<FullNameResponse> addFullName(String fullname) async {
    final data = await post('/add-fullname', {
      'fullname': fullname,
    }, requiresAuth: true);
    return FullNameResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> uploadProfilePicture(String filePath) async {
    await _loadToken();

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/user/add-picture'),
    );

    if (token != null && token!.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'picture',
        filePath,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    try {
      final data = json.decode(responseBody);
      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Failed to upload picture');
      }
    } catch (e) {
      throw Exception("Failed to parse response: $responseBody");
    }
  }

  Future<Map<String, dynamic>> createUser({
    required String fullname,
    required String email,
    required String phone,
    required String picture,
  }) async {
    final body = {
      "fullname": fullname,
      "email": email,
      "phone": phone,
      "picture": picture,
    };

    final response = await post('/create-user', body, requiresAuth: false);
    return response;
  }

  Future<Map<String, dynamic>> getUser() async {
    await _loadToken();

    final response = await http.get(
      Uri.parse('$baseUrl/user/get-user'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token!.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Failed to fetch user');
    }
  }

  Future<SubjectResponseModel> getSubjects() async {
    await _loadToken();

    final response = await http.get(
      Uri.parse('$baseUrl/data/subjects'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token!.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SubjectResponseModel.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Failed to fetch subjects');
    }
  }

  Future<BannerResponseModel> getBanner() async {
    await _loadToken();

    final response = await http.get(
      Uri.parse('$baseUrl/data/banner'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token!.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BannerResponseModel.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Failed to fetch banner');
    }
  }

  Future<CourseResponseModel> getCourses() async {
    await _loadToken();

    final response = await http.get(
      Uri.parse('$baseUrl/data/courses'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token!.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CourseResponseModel.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Failed to fetch courses');
    }
  }

  Future<MaterialResponseModel> getMaterials() async {
    await _loadToken();

    final response = await http.get(
      Uri.parse('$baseUrl/data/materials'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null && token!.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MaterialResponseModel.fromJson(data);
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Failed to fetch materials');
    }
  }
}
