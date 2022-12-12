

import 'package:flutter/material.dart';
import 'package:kursova_bd/logic/classes.dart';
import '../../logic/processing.dart';

class ReportPage extends StatelessWidget {
  final User currentuser;
  const ReportPage({super.key, required this.currentuser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFA2A6B1),
                  ),
                  onPressed: () {
                    print('sent');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginPage()));
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (r) => false);
                  },
                ),
              ],
            ),
            const Text('ReportPage')
          ],
        ),
      ),
    );
  }
}
