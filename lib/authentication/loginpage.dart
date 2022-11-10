import 'package:flutter/material.dart';
import 'package:kursova_bd/authentication/registrationpage.dart';

import '../theme/patternfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF273746),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, left: 40, bottom: 50),
            child: Text(
              'Log In',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const AppField(lable: 'E-mail', bottompadding: 40,),
          const AppField(lable: 'Password', ispassword: true, bottompadding: 40,),
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
                "Log in",
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
              const Text('Dont have account?',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistrationPage()));
                },
                child: const Text('Register',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3498DB),
                        fontWeight: FontWeight.w700)),
              )
            ],
          )
        ],
      ),
    );
  }
}
