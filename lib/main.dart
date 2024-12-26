import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; 
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/scholarships_screen.dart';
//import 'screens/scholarship_detail_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/scholarships': (context) => ScholarshipsScreen(),
      },
    );
  }
}
