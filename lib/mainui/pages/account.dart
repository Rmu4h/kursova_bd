import 'package:flutter/material.dart';
import 'package:kursova_bd/mainui/pages/producers.dart';
import 'package:kursova_bd/mainui/pages/products.dart';
import 'package:kursova_bd/mainui/pages/report.dart';

import '../../authentication/login-page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = [
      'user Full Name',
      'user Document No.',
      'user Phone',
      'user email',
      'Password'
    ];
    final List<dynamic> icons = [
      Icons.account_circle,
      Icons.insert_drive_file_outlined,
      Icons.phone,
      Icons.email,
      Icons.edit
    ];
    final nameRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{3,}$');

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                    },
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/avatar.png')),
              ),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          // height: 30,
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                icons[index],
                                color: const Color(0xFF613CEA),
                              ),
                              Text(' ${entries[index]}',
                                  // textAlign: TextAlign.center,
                                  style: const TextStyle(
                                        // color: Color(0xFF613CEA),
                                      )),
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      // height: 1,
                      thickness: 1,
                      // indent: 20,
                      endIndent: 0,
                      color: Colors.black,
                    ),
                  )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF613CEA),
                  padding: const EdgeInsets.fromLTRB(40,20,40,20),
                ),
                onPressed: () {
                  final TextEditingController _name = TextEditingController(text: "Old Name");
                  final TextEditingController _surname = TextEditingController(text: "Old Surname");
                  final TextEditingController _patronymic = TextEditingController(text: "Old Patronymic");
                  final TextEditingController _docNo = TextEditingController(text: "Old Name");
                  final TextEditingController _email = TextEditingController(text: "Old Email");
                  final TextEditingController _phone = TextEditingController(text: "Old Phone");


                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    builder: (_) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                        height: MediaQuery.of(context).size.height* 0.9,
                        // color: Colors.amber,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Color(0xFFA2A6B1),
                                      ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'Change personal information',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // height: 5,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  CustomFormField(
                                    hintText: "Name",
                                    controller: _name,
                                    validator: (val) {
                                      if (!nameRegExp.hasMatch(val!)) return 'Enter valid name';
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomFormField(
                                    hintText: 'Surname',
                                    controller: _surname,

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
                                    controller: _patronymic,

                                    validator: (val) {
                                      if (!nameRegExp.hasMatch(val!)) {
                                        return 'Enter valid patronymic';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  CustomFormField(
                                    hintText: 'Old Document No.',
                                    controller: _docNo,

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
                                    controller: _phone,

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
                                    controller: _email,

                                    validator: (val) {
                                      final emailRegExp =
                                      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                      if (!emailRegExp.hasMatch(val!)) {
                                        return 'Enter valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF613CEA),
                                  // backgroundColor: const Color(0xFFA2A6B1),

                                  padding: const EdgeInsets.fromLTRB(40,20,40,20),
                                ),
                                child: const Text('SAVE CHANGES'),
                                onPressed: () => {
                                  Navigator.pop(context),
                                  print('sent'),
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Edit profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }



  showModalWindow(){

  }
}


