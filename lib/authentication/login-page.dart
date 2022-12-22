import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kursova_bd/authentication/registration-page.dart';
import 'package:kursova_bd/logic/processing.dart';

import '../mainui/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    this.hintText = '',
    this.inputFormatters,
    this.validator,
    this.controller,
  }) : super(key: key);

  final String hintText;

  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  var controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  //ключ який юзається для ідентифікації стану форми (це рома для себе, боді не чиати ALERT!!!)
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF613CEA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70, left: 40, bottom: 40),
              child: Text(
                'Log In',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            //inputs
            Container(
              margin: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      controller: _email,
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
                    const SizedBox(height: 20),
                    CustomFormField(
                      controller: _password,
                      hintText: 'Password',
                      validator: (val) {
                        final passwordRegExp = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                        if (!passwordRegExp.hasMatch(val!)) {
                          return 'Enter valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                top: 20, bottom: 20, left: 90, right: 90)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Processing.userLogin(_email.text, _password.text)
                              .then((value) {
                            Navigator.popAndPushNamed(context, '/main', arguments: value);
                          }).onError(
                            (error, stackTrace) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Account not find'),
                                  content: Text(error.toString()),
                                  actions: <Widget>[
                                    Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 90,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          backgroundColor:
                                              const Color(0xFF613CEA),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text('Close'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "LOG IN",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF6040E5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have account?',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFEBE7FF).withOpacity(0.1))),
                  child: const Text('Register',
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
