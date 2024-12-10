import 'dart:convert';

import 'package:http/http.dart' as http;

// Fetches data from a given URL using an HTTP GET request
// Function will perform an asynchronous operation and return a String
// It also takes url in String format as a parameter
Future<String> fetchdata(String url) async {
  try {
    // It makes an HTTP GET request to the provided url. Uri.parse(url) converts 
    // the URL string into a Uri object required by the http.get function.
    final http.Response response = await http.get(Uri.parse(url));

    // Error Handling
    // 200 status code means correct working and return the response as String
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Else throw an exception as Failed to load data
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}


// This function performs HTTP POST operation to specified URL and sends data in JSON format
// Function contains two parameters. url to which POST request will be sent and query which
// is the data that will be included
// It performs async operation and return response once operation is performed successfully
Future<String> postdata(String url, String query) async {
  try {
    // Sending HTTP POST request
    final response = await http.post(
      // Converts url<String> to uri object as required by http.post
      Uri.parse(url),
      // Header that shows the type of the content is json data
      headers: {'Content-Type': 'application/json'},
      // Contains the body
      // The query string is wrapped in a map {'query': query}, and then encoded to JSON using jsonEncode
      body: jsonEncode({'query': query})
    );

    // Error Handling
    // 200 status code means correct working and return the response as String
    if (response.statusCode == 200){
      return response.body;
    } else {
      // Else throw an exception as Failed to load data
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}


// This function performs HTTP PUT operation to specified URL and sends data in JSON format
// Function contains two parameters. url to which PUT request will be sent and query which
// represent the data to be sent in the request body.
// It performs async operation and return response once operation is performed successfully
Future<String> putdata(String url, String query) async {
  try {
    // Sending HTTP PUT request
    final response = await http.put(
      // Converts url<String> to uri object as required by http.put
      Uri.parse(url),
      // Header that shows the type of the content is json data
      headers: {'Content-Type': 'application/json'},
      // Contains the body
      // The query string is wrapped in a map {'query': query}, and then encoded to JSON using jsonEncode
      body: jsonEncode({'query': query}),
    );

    // Error Handling
    // 200 status code means correct working and return the response as String
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Else throw an exception as Failed to load data
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}

// defines a Dart function deletedata that sends an HTTP DELETE request to a specified 
// URL with a JSON-encoded body containing the query parameter
Future<String> deletedata(String url, String query) async {
  try {
    // Sending HTTP DELETE request
    final response = await http.delete(
      // Converts url<String> to uri object as required by http.delete
      Uri.parse(url),
      // Header that shows the type of the content is json data
      headers: {'Content-Type': 'application/json'},
      // Contains the body
      // The query string is wrapped in a map {'query': query}, and then encoded to JSON using jsonEncode
      body: jsonEncode({'query': query}),
    );

    // Error Handling
    // 200 status code means correct working and return the response as String
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Else throw an exception as Failed to load data
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
