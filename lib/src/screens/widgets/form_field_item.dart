import 'package:flutter/material.dart';

class FormFieldItem extends StatelessWidget {
  final String header;
  final String hint;
  final bool obsecureText;
  final TextEditingController controller;

  FormFieldItem(this.header, this.hint, this.obsecureText, this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obsecureText,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffEBEBEB),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
