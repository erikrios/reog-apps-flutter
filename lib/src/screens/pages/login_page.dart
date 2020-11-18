import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/authentication_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/auth_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/auth_result_state.dart';
import 'package:reog_apps_flutter/src/models/auth.dart';
import 'package:reog_apps_flutter/src/screens/pages/dashboard_page.dart';
import 'package:reog_apps_flutter/src/screens/pages/register_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/form_field_item.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final AuthenticationBloc _bloc =
      AuthenticationBloc(service: ReogAppsService.create());

  @override
  Widget build(BuildContext context) {
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
                          child:
                              BlocBuilder<AuthenticationBloc, AuthResultState>(
                            cubit: _bloc,
                            builder:
                                (BuildContext context, AuthResultState state) {
                              print(state.toString());
                              if (state is AuthResultInitialState) {
                                return RaisedButton(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  color: Color(0xffE6CB34),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onPressed: () {
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    if (!_validateLogin(email, password)) {
                                      final snackbar = SnackBar(
                                        content:
                                            Text('Invalid email or password'),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackbar);
                                    } else {
                                      _bloc.add(Authenticating(Auth(
                                          email: email, password: password)));
                                    }
                                  },
                                  child: Text(
                                    'login'.tr().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 26, color: Colors.white),
                                  ),
                                );
                              } else if (state is AuthResultLoadingState) {
                                return Center(
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.amber),
                                      )),
                                );
                              } else if (state is AuthResultSuccessState) {
                                _navigateToDashboard(context);
                                return SizedBox();
                              } else {
                                print('Error state');
                                final snackbar = SnackBar(
                                    content: Text(
                                        (state as AuthResultErrorState).error));
                                Scaffold.of(context).showSnackBar(snackbar);
                                return SizedBox();
                              }
                            },
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

  void _navigateToDashboard(BuildContext context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return DashboardPage();
    }));
  }

  bool _validateLogin(String email, String password) {
    bool isValid = true;

    if (email.isEmpty || password.isEmpty) isValid = false;
    if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(email) ||
        password.length < 5) isValid = false;

    return isValid;
  }
}
