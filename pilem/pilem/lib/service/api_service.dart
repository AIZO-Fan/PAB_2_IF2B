import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apikey = '118ac40143749b62d7cf3af06c77a775';

  Future<List<Map<String,dynamic>>> getallMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/now_playing?api_key=$apikey'));

  final data = json.decode(response.body);
  return List<Map<String, dynamic>>.from(data['results']);
  }
}