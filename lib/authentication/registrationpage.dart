import 'package:flutter/material.dart';

import '../theme/patternfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF273746),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70, left: 40, bottom: 50),
              child: Text(
                'Registration',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const AppField(
              lable: 'Name',
              bottompadding: 10,
            ),
            const AppField(
              lable: 'Surname',
              bottompadding: 10,
            ),
            const AppField(
              lable: 'Patronimic',
              bottompadding: 10,
            ),
            const AppField(
              lable: 'Passport ID',
              bottompadding: 10,
            ),
            const AppField(
              lable: 'Phone',
              bottompadding: 10,
            ),
            const AppField(
              lable: 'E-mail',
              bottompadding: 10,
            ),
            const AppField(
                lable: 'Password', bottompadding: 10, ispassword: true),
            const AppField(
                lable: 'Repeat password', bottompadding: 10, ispassword: true),
            Center(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 20, bottom: 20, left: 90, right: 90)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF3498DB)),
                ),
                onPressed: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account?',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Log in',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3498DB),
                          fontWeight: FontWeight.w700)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
