import 'dart:convert'; // JSON
import 'package:http/http.dart' as http; // solicitud HTTP

class ApiService {
  final String baseUrl = 'http://localhost:8086/api';

  Future<String> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error en login: ${response.body}');
    }
  }

  Future<String> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en registro: ${response.body}');
    }
  }

  Future<List<dynamic>> getAllScholarships() async {
    final response = await http.get(Uri.parse('$baseUrl/scholarships/get_all'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener becas: ${response.body}');
    }
  }
}
