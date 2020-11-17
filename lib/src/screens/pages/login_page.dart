import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/authentication_bloc.dart';
import 'package:reog_apps_flutter/src/screens/pages/register_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/form_field_item.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  AuthenticationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[700], Colors.lightGreen[300]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Text(
                        'login'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Flexible(
                flex: 4,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 28, right: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormFieldItem('email_address'.tr(), 'email_hint'.tr(),
                          false, emailController),
                      FormFieldItem('password'.tr(), 'password_hint'.tr(), true,
                          passwordController),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            color: Color(0xffE6CB34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              print(emailController.text);
                              print(passwordController.text);
                            },
                            child: Text(
                              'login'.tr().toUpperCase(),
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'have_not_account'.tr(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            _navigateToRegister(context);
                          },
                          child: Text(
                            'register'.tr(),
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRegister(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RegisterPage();
    }));
  }
}
