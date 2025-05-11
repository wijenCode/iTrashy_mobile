import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'pilih_sampah_screen.dart';
import 'cart_screen.dart';
// import 'edukasi_screen.dart';
// import 'artikel_detail.dart';
// import 'video_detail.dart';
import 'order_screen.dart'; 
import 'edit_order_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/pilih_sampah': (context) => PilihSampahScreen(),
        '/cart': (context) {
          // Mengambil arguments dari rute
          final selectedItems = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
          return CartScreen(selectedItems: selectedItems);
        },
        '/order': (context) => OrderScreen(), 
        '/edit_order': (context) => EditOrderScreen(), 
      },
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: Colors.white,
      ),
    );
  }
}