import 'package:flutter/material.dart';
import 'package:kursova_bd/logic/processing.dart';
import 'package:kursova_bd/mainui/navigation.dart';
import 'package:kursova_bd/mainui/pages/producers.dart';
import 'package:kursova_bd/mainui/pages/products.dart';
import 'package:kursova_bd/mainui/pages/report.dart';

import '../../authentication/login-page.dart';
import '../../logic/classes.dart';

class AccountPage extends StatelessWidget {
  final User currentuser;
  const AccountPage({super.key, required this.currentuser});

  @override
  Widget build(BuildContext context) {
    final List<String> entries = [
      'Name: ${currentuser.name}',
      'Surname: ${currentuser.surname}',
      'Patronymic ${currentuser.patronymic}',
      'Document No.${currentuser.passportId}',
      'user Phone: ${currentuser.phone}',
      'user email ${currentuser.email}',
      'Password'
    ];
    final List<dynamic> icons = [
      Icons.account_circle,
      Icons.account_circle,
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
                      Navigator.popAndPushNamed(context, "/");
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
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                ),
                onPressed: () {
                  final TextEditingController _name =
                      TextEditingController(text: "${currentuser.name}");
                  final TextEditingController _surname =
                      TextEditingController(text: "${currentuser.surname}");
                  final TextEditingController _patronymic =
                      TextEditingController(text: "${currentuser.patronymic}");
                  final TextEditingController _docNo =
                      TextEditingController(text: "${currentuser.passportId}");
                  final TextEditingController _email =
                      TextEditingController(text: "${currentuser.email}");
                  final TextEditingController _phone =
                      TextEditingController(text: "${currentuser.phone}");

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
                        height: MediaQuery.of(context).size.height * 0.9,
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
                                      if (!nameRegExp.hasMatch(val!))
                                        return 'Enter valid name';
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
                                      final phoneRegExp =
                                          RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

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
                                      final emailRegExp = RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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

                                  padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                ),
                                child: const Text('SAVE CHANGES'),
                                onPressed: () {
                                  var temp_user = User(
                                    userId: currentuser.userId,
                                    name: _name.text,
                                    surname: _surname.text,
                                    patronymic: _patronymic.text,
                                    phone: _phone.text,
                                    passportId: _docNo.text,
                                    email: _email.text,
                                    password: currentuser.password,
                                  );
                                  Processing.updateUser(temp_user)
                                      .then((value) {
                                    if (value == 'success') {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (_) => WillPopScope(
                                          onWillPop: ()=>Future.value(false),
                                          child: AlertDialog(
                                            title: const Text('Account edited!'),
                                            content: const Text(
                                                'Successfully edited profile'),
                                            actions: <Widget>[
                                              Center(
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 90,
                                                  child: FloatingActionButton(
                                                    onPressed: () {
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              '/main',
                                                              arguments:
                                                                  temp_user,
                                                              ((route) => false));
                                                    },
                                                    backgroundColor:
                                                        const Color(0xFF613CEA),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Text('Close'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Error ocured!'),
                                          content: const Text(
                                              'This e-mail used by another user'),
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
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Text('Close'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                  Navigator.pop(context);
                                  print('sent');
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

  showModalWindow() {}
}
