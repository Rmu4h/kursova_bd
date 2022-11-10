import 'package:flutter/material.dart';
import 'package:kursova_bd/mainui/pages/account.dart';
import 'package:kursova_bd/mainui/pages/producers.dart';
import 'package:kursova_bd/mainui/pages/products.dart';
import 'package:kursova_bd/mainui/pages/report.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int curpage = 0;
  List pages = const [
    ProductPage(),
    ProducerPage(),
    ReportPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curpage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: const Color(0xFF2874A6),
        unselectedItemColor: const Color(0xFF3498DB),
        currentIndex: curpage,
        onTap: (index) {
          setState(() {
            curpage = index;
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
