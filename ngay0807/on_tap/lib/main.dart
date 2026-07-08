import 'package:flutter/material.dart';
import 'Bai4_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        fontFamily: 'k2d',
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),

        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.lightGreen, // Màu con trỏ
          selectionColor: Colors.lightGreen.withOpacity(0.3),
          selectionHandleColor: Colors.lightGreen,
        ),

        inputDecorationTheme: InputDecorationTheme(

          labelStyle: TextStyle(
            color: Colors.lightGreen[900],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24)
          ),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen[800]!),
              borderRadius: BorderRadius.circular(24)
          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen[800]!, width: 2),
              borderRadius: BorderRadius.circular(24)
          ),
        ),
      ),
      home: UploadAvatar(),
    );
  }
}