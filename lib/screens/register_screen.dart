import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _apiService = ApiService();

  // Método para manejar el registro
  void _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;


    if (username.isEmpty || password.isEmpty) {
      // Si alguno de los campos está vacío, muestra un error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor ingresa ambos campos'),
      ));
    } else {
      try {
        final response = await _apiService.register(username, password);

        if (response == "User created successfully") {
          Navigator.pushNamed(context, '/login');
        } else {
          throw Exception("Register failed: $response");
        }

      } catch (e) {
        // Manejo de errores (si la llamada al backend falla)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Campo de texto para el username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para el password
            TextField(
              controller: _passwordController,
              obscureText: true, // Para ocultar el texto ingresado
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Botón de registro
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
