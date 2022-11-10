import 'package:flutter/material.dart';

class AppField extends StatelessWidget {
  final String lable;
  final bool ispassword;
  final double bottompadding;
  const AppField({super.key, required this.lable, this.bottompadding=0, this.ispassword = false} );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: bottompadding),
      child: TextField(
                obscureText: ispassword,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: lable,
                ),
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF787878),
                ),
              ),
    );
  }
}