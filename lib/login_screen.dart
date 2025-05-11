import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/kids.png', fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextField(decoration: InputDecoration(labelText: 'Email Address')),
                  TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: Text('Lupa password?')),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Center(child: Text('Login')),
                    style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Belum punya akun? Daftar Sekarang'),
                    ),
                  ),
                  Divider(height: 30),
                  Center(child: Text('Or continue with')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.g_mobiledata, size: 40), onPressed: () {}),
                      IconButton(icon: Icon(Icons.apple, size: 40), onPressed: () {}),
                      IconButton(icon: Icon(Icons.facebook, size: 40), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
