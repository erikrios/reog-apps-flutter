import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/widgets/form_field_item.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController rePasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[700], Colors.lightGreen[300]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text(
                    'register'.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 28, right: 28),
                child: ListView(
                  children: [
                    FormFieldItem('full_name'.tr(), 'full_name_hint'.tr(),
                        false, fullNameController),
                    SizedBox(height: 4),
                    FormFieldItem('email_address'.tr(), 'email_hint'.tr(),
                        false, emailController),
                    SizedBox(height: 4),
                    FormFieldItem('password'.tr(), 'password_hint'.tr(), true,
                        passwordController),
                    SizedBox(height: 4),
                    FormFieldItem('re_password'.tr(), 're_password_hint'.tr(),
                        true, rePasswordController),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    color: Color(0xffE6CB34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {},
                    child: Text(
                      'register'.tr().toUpperCase(),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateRegister(String name, String email, String password) {
    bool isValid = true;

    if (name.isEmpty || email.isEmpty || password.isEmpty) isValid = false;
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(email) ||
        password.length < 5) isValid = false;

    return isValid;
  }
}
