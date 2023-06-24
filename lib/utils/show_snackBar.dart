import 'package:flutter/material.dart';

showSnack(context, String tittle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      //backgroundColor: Colors.red,
      content: Text(tittle),
    ),
  );
}
