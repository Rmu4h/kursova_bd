import 'package:flutter/material.dart';
import 'authentication/login-page.dart';
import 'authentication/registration-page.dart';
import 'mainui/navigation.dart';
import 'mainui/pages/account.dart';



void main() {
  runApp(const StorageApplication());
}

class StorageApplication extends StatelessWidget {
  const StorageApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MainPage(),
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MainPage(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        // '/main': (context) => const LoginPage(),

      },
    );
  }
}