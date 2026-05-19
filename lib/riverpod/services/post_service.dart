import 'dart:convert';

import 'package:bench_boost_program/riverpod/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> items = json.decode(response.body);
        posts = items.map((item) => PostModel.fromJson(item)).toList();
      } else {
        print('Error Occurred: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred: $e');
    }
    return posts;
  }
}
