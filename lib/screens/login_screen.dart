import 'package:flutter/material.dart'; // widgets
import '../services/api_service.dart'; //service

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService();

  void _login() async {
    try {
      final response = await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (response == "Login successful") {
        // Si la respuesta es un mensaje de texto simple
        Navigator.pushNamed(context, '/scholarships');
      } else {
        throw Exception("Login failed: $response");
      }
      //Navigator.pushNamed(context, '/scholarships', arguments: response);
    } catch (e) { // sino mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
