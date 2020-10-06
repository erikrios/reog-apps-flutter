import 'dart:ui';

import 'package:flutter/material.dart';

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
          padding: EdgeInsets.symmetric(vertical: 70,horizontal: 30), child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                  height: 160,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
                  )),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Adress',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        validator: (String value) {
                          return value.isEmpty ? 'Enter your Email adress *' : null;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Enter your Email adress',
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
                      'Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      validator: (String value) {
                        return value.isEmpty ? 'Enter your Pasword *' : null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Pasword',
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
                    child: Text('LOGIN', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
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
                    'Haven\'t an account?',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.yellow, fontSize: 20, decoration: TextDecoration.underline),
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
