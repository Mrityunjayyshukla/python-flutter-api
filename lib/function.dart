import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> fetchdata(String url) async {
  try {
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<String> postdata(String url, String query) async {
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query})
    );

    if (response.statusCode == 200){
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<String> putdata(String url, String query) async {
  try {
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

Future<String> deletedata(String url, String query) async {
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': query}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
