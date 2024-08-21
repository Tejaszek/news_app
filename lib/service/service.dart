import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/new_model.dart';

class Service {
  final String _baseUrl = 'https://newsapi.org/v2/everything';
  final String _apiKey = '002b387b6f35483eb656b035570d63a6';

  Future<List<Article>> fetchArticles({String query = 'tesla'}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl?q=$query&from=2024-07-20&sortBy=publishedAt&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
