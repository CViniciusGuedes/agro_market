import 'package:agro_market/vendor/views/screens/earnings_screen.dart';
import 'package:agro_market/vendor/views/screens/edit_product_screen.dart';
import 'package:agro_market/vendor/views/screens/upload_screen.dart';
import 'package:agro_market/vendor/views/screens/vendor_logout_screen.dart';
import 'package:agro_market/vendor/views/screens/vendor_order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  //_pageIndex serve para referenciar as paginas, associadas aos BottonNavigationBar()
  int _pageIndex = 0;

  //Serve para direcionar
  List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: 'Ganhos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload), label: 'Anunciar'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Editar'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'Vendas'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LogOut'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
