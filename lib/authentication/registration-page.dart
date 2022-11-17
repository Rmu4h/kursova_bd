import 'package:flutter/material.dart';
import 'login-page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final nameRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{3,}$');
  final passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  late String _password;

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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFormField(
                    hintText: 'Name',
                    validator: (val) {
                      if (!nameRegExp.hasMatch(val!)) return 'Enter valid name';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Surname',
                    validator: (val) {
                      if (!nameRegExp.hasMatch(val!)) {
                        return 'Enter valid surname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Patronymic',
                    validator: (val) {
                      if (!nameRegExp.hasMatch(val!)) {
                        return 'Enter valid patronymic';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Document No.',
                    validator: (val) {
                      final idExp = RegExp(r"^[0-9]{9}$");

                      if (!idExp.hasMatch(val!)) {
                        return 'Enter valid Document No.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Phone',
                    validator: (val) {
                      final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

                      if (!phoneRegExp.hasMatch(val!)) {
                        return 'Enter valid Phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Email',
                    validator: (val) {
                      final emailRegExp =
                          RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if (!emailRegExp.hasMatch(val!)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Password',
                    validator: (val) {
                      if (!passwordRegExp.hasMatch(val!)) {
                        return 'Enter valid password';
                      } else {
                        _password = val;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    hintText: 'Repeat password',
                    validator: (val) {
                      if ((!passwordRegExp.hasMatch(val!)) &&
                          val != _password) {
                        return 'Enter valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          top: 20, bottom: 20, left: 90, right: 90)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF3498DB)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ));
                      }
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
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
