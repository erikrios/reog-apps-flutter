import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/register_event.dart';
import 'package:reog_apps_flutter/src/bloc/register_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/register_state.dart';
import 'package:reog_apps_flutter/src/models/register.dart';
import 'package:reog_apps_flutter/src/screens/widgets/form_field_item.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController rePasswordController =
      new TextEditingController();
  final RegisterBloc _bloc = RegisterBloc(service: ReogAppsService.create());

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
                  child: BlocBuilder<RegisterBloc, RegisterState>(
                    cubit: _bloc,
                    builder: (BuildContext context, RegisterState state) {
                      if (state is RegisterLoadingState) {
                        return Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.amber),
                            ),
                          ),
                        );
                      } else if (state is RegisterSuccessState) {
                        _saveToken(state.authToken);
                        _navigateToDashboard(context);
                        return SizedBox();
                      } else {
                        if (state is RegisterErrorState) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                        return RaisedButton(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          color: Color(0xffE6CB34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            String name = fullNameController.text;
                            String email = emailController.text;
                            String password = passwordController.text;
                            String rePassword = rePasswordController.text;
                            if (!_validateRegister(
                                name, email, password, rePassword)) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Invalid full name, email, or password')));
                            } else {
                              _bloc.add(Registering(Register(
                                  name: name,
                                  email: email,
                                  password: password)));
                            }
                          },
                          child: Text(
                            'register'.tr().toUpperCase(),
                            style: TextStyle(fontSize: 26, color: Colors.white),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveToken(String authToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AUTH_TOKEN_SHARED_PREFS_KEY, authToken);
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  bool _validateRegister(
      String name, String email, String password, String rePassword) {
    bool isValid = true;

    if (name.isEmpty || email.isEmpty || password.isEmpty) isValid = false;
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(email) ||
        password.length < 5) isValid = false;
    if (!(password == rePassword)) isValid = false;

    return isValid;
  }
}
