import 'package:flutter/material.dart';
import 'login-page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // final TextEditingController _name = TextEditingController(text: "Old Name");
  // final TextEditingController _surname = TextEditingController(text: "Old Surname");
  // final TextEditingController _patronymic = TextEditingController(text: "Old Patronymic");
  // final TextEditingController _docNo = TextEditingController(text: "Old Name");
  // final TextEditingController _email = TextEditingController(text: "Old Email");
  // final TextEditingController _phone = TextEditingController(text: "Old Phone");

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final nameRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{3,}$');
  final passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF613CEA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
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
                    // controller: _name,
                    hintText: "Name",

                    validator: (val) {
                      if (!nameRegExp.hasMatch(val!)) return 'Enter valid name';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    // controller: _surname,
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
                    // controller: _patronymic,
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
                    // controller: _docNo,
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
                    // controller: _phone,
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
                    // controller: _email,
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
                    controller: _pass,
                    hintText: 'Password',

                    validator: (val) {
                      if (!passwordRegExp.hasMatch(val!)) {
                        return 'Password must contain at least 1 upper case,1 lower case, numeric, and special character';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    controller: _confirmPass,
                    hintText: 'Repeat password',

                    validator: (val) {
                      // if ((!passwordRegExp.hasMatch(val!))) {
                      //   return 'Enter valid password';
                      // }
                      if(val != _pass.text) {
                        return 'Not Match';
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
                          MaterialStateProperty.all(Colors.white),
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
                      style: TextStyle(fontSize: 20, color: Color(0xFF613CEA)),
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
                          color: Colors.white,
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
