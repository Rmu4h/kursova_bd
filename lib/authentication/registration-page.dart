import 'package:flutter/material.dart';
import '../logic/classes.dart';
import '../logic/processing.dart';
import 'login-page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _patronymic = TextEditingController();
  final TextEditingController _docNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

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
                    controller: _name,
                    hintText: "Name",

                    validator: (val) {
                      if (!nameRegExp.hasMatch(val!)) return 'Enter valid name';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    controller: _surname,
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
                    controller: _patronymic,
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
                    controller: _docNo,
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
                    controller: _phone,
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
                        print('${_name.text} - _name is done');
                        print('${_email.text} - _email is done');
                        print('${_phone.text} - _phone.text is done');
                        print('${_docNo.text} - _docNo.text is done');
                        print('${_pass.text} - _pass.text is done');

                        var newUser = User(
                            userId: 2,
                            name: _name.text,
                            surname: _surname.text,
                            patronymic: _patronymic.text,
                            passportId: _docNo.text,
                            phone: _phone.text,
                            email: _email.text,
                            password: _pass.text,
                        );

                        print('${newUser} - newUser already create');

                        Processing.registerUser(newUser).then((value) {
                          if(value == 'success'){
                            print('ok');
                          }
                          if(value == 'error'){
                            print('this email is registered');
                          }
                          if(value == 'Connection error'){
                            print('Connection error');
                          }
                          if(value == 'exeption'){
                            print('exeption');
                          }
                        }
                        );
                        print('${newUser} - registerUser func done');

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
