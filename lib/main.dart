import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
// import 'pilih_sampah_screen.dart';
import 'cart_screen.dart';
import 'edukasi_screen.dart';
import 'order_screen.dart'; 
import 'edit_order_screen.dart';
import 'tukarpoin_screen.dart';
import 'voucher_detail_screen.dart';
import 'sembako_detail_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTrashy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        // '/pilih_sampah': (context) => PilihSampahScreen(),
        '/cart': (context) {
          // Mengambil arguments dari rute
          final selectedItems = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
          return CartScreen(selectedItems: selectedItems);
        },
        '/order': (context) => OrderScreen(), 
        '/edit_order': (context) => EditOrderScreen(),
        '/edukasi': (context) => const EdukasiBeranda(),
        '/tukarpoin': (context) => TukarPoinScreen(),
        '/voucher_detail': (context) => VoucherDetailScreen(),
        '/sembako_detail': (context) => SembakoDetailScreen(),
      },
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}