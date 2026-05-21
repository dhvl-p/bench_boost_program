import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bench_boost_program/getx/model/photo_model.dart';

class PhotoService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Fetches all photos from the API.
  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$_baseUrl/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }
}
