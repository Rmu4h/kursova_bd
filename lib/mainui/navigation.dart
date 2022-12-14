import 'package:flutter/material.dart';
import 'package:kursova_bd/mainui/pages/account.dart';
import 'package:kursova_bd/mainui/pages/producers.dart';
import 'package:kursova_bd/mainui/pages/products.dart';
import 'package:kursova_bd/mainui/pages/report.dart';

import '../logic/classes.dart';

class MainPage extends StatefulWidget {
  final User currentuser;
  const MainPage({super.key, required this.currentuser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final currentuser = widget.currentuser;
  int currentPage = 0;
  late List pages = [
    ProductPage(currentuser: currentuser),
    ProducerPage(),
    ReportPage(currentuser: currentuser),
    AccountPage(currentuser: currentuser,)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,   // <-- HERE
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: const Color(0xFF613CEA),

        // selectedFontSize: 24.0,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, size: 30),
            label: "Producers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "My account",
          ),
        ],
      ),
    );
  }
}

class ArgsForMainPage extends StatelessWidget {
  const ArgsForMainPage({super.key});


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;
    return MainPage(currentuser: args);
  }
}