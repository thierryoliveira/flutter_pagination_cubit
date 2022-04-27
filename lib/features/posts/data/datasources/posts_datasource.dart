import 'dart:convert';
import 'package:http/http.dart';

class PostsDatasource {
  static const fetchLimit = 5;

  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<dynamic>> fetchPosts({required int page}) async {
    try {
      final response =
          await get(Uri.parse(baseUrl + '?_limit=$fetchLimit&_page=$page'));
      return jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}
