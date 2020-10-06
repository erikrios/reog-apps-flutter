import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff97DA7B),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  height: 160,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'login'.tr().toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'email_address'.tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        validator: (String value) {
                          return value.isEmpty ? 'email_hint'.tr() : null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'email_hint'.tr().toString(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'password'.tr(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      validator: (String value) {
                        return value.isEmpty ? 'password_hint'.tr() : null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'password_hint'.tr(),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onSaved: (String value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.yellow.shade700,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Text('login'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20)),
                  ),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                  },
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Text(
                    'have_not_account'.tr(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'register'.tr(),
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
          ),
        ));
  }
}
