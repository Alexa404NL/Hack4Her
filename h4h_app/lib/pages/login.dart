import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> login() async {
  final response = await http.get(Uri.parse('http://localhost:8000/login'));
  debugPrint(response.body);
}

Future<void> signup() async {
  final response = await http.post(Uri.parse('http://localhost:8000/signup'));
  debugPrint(response.body);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => {signup()},
          child: Icon(Icons.add, color: Colors.red)
        )
        ),
    );
  }
}