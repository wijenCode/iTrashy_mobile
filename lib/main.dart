import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'setor_sampah.dart';
import 'cart_screen.dart';
// import 'edukasi_screen.dart';
// import 'artikel_detail.dart';
// import 'video_detail.dart';
import 'order_screen.dart'; 
import 'edit_order_screen.dart';  
import 'notif_screen.dart';
import 'chat_screen.dart';
import 'order_detail_screen.dart';


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
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/notification': (context) => NotificationScreen(),
        '/setor_sampah': (context) => SetorSampahScreen(),
        // '/setor_sampah': (context) => SetorSampahScreen(),
        '/cart': (context) {
          // Mengambil arguments dari rute
          final selectedItems = ModalRoute.of(context)?.settings.arguments as List<Map<String, dynamic>>;
          return CartScreen(selectedItems: selectedItems);
        },
        '/order': (context) => OrderScreen(), 
        '/edit_order': (context) => EditOrderScreen(),
        '/order_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return OrderDetailScreen(
            address: args['address'],
            pickupDate: args['pickupDate'],
            pickupTime: args['pickupTime'],
            selectedItems: args['selectedItems'],
            totalWeight: args['totalWeight'],
            totalPoints: args['totalPoints'],
            serviceFee: args['serviceFee'],
            finalTotal: args['finalTotal'],
          );
        },
        '/chat': (context) {
          final pickerName = ModalRoute.of(context)?.settings.arguments as String;
          return ChatScreen(pickerName: pickerName);
        },
      },
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: Colors.white,
      ),
    );
  }
}