import 'package:flutter/material.dart';
import '../../../vendor/views/auth/vendor_auth.dart';
import '../auth/login_screen.dart';

class OpenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfff0d9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFfff0d9),
        title: Text(
          'Bem-Vindo',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/agro.png',
            width: 500,
            height: 400,
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('Login Comprador'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VendorAuthScreen()),
              );
            },
            child: Text('Login Vendedor'),
          ),
        ],
      ),
    );
  }
}
