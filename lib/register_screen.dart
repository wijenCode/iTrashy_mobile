import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Buat akunmu sekarang dan mulai langkah kecil untuk bumi kita!", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: 'Nama')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'Create a password')),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirm password')),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "I've read and agree with the ",
                      children: [
                        TextSpan(text: "Terms and Conditions", style: TextStyle(color: Colors.blue)),
                        TextSpan(text: " and the "),
                        TextSpan(text: "Privacy Policy", style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Center(child: Text('Daftar')),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Sudah punya akun? Login'),
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
    );
  }
}
