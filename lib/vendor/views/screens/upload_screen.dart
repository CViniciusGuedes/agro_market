import 'package:agro_market/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:agro_market/vendor/views/screens/upload_tab_screens/images_screen.dart';
import 'package:agro_market/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'Geral',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Entrega',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Imagens',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          GeneralScreen(),
          ShippingScreen(),
          ImagesScreen(),
        ]),
      ),
    );
  }
}
