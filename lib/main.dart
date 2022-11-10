import 'package:flutter/material.dart';
import 'package:kursova_bd/mainui/navigation.dart';
import 'authentication/loginpage.dart';


void main() {
  runApp(const StorageApplication());
}

class StorageApplication extends StatelessWidget {
  const StorageApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage(),);
  }
}