import 'package:agro_market/vendor/views/auth/vendor_auth.dart';
import 'package:agro_market/vendor/views/screens/main_vendor_screen.dart';
import 'package:agro_market/views/buyers/auth/login_screen.dart';
import 'package:agro_market/views/buyers/auth/register_screen.dart';
import 'package:agro_market/views/buyers/main_screen.dart';
import 'package:agro_market/views/buyers/nav_screens/cart_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroMarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 119, 118, 119)),
        useMaterial3: true,
        //fontFamily: 'Brand-Bold',
      ),
      home: MainVendorScreen(),
      //home: VendorAuthScreen(),
      //builder: EasyLoading.init(),
    );
  }
}
