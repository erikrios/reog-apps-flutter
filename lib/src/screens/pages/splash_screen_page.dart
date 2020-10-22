import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reog_apps_flutter/src/screens/pages/dashboard_page.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _startSplashScreen(context);

    return Scaffold(
      backgroundColor: Color(0xff97DA7B),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: _getSplashScreenLogo(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                'app_name'.tr(),
                style: TextStyle(
                  color: Color(0xffFEE97D),
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _startSplashScreen(BuildContext context) async {
    final duration = Duration(milliseconds: 1500);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return DashboardPage();
      }));
    });
  }

  Widget _getSplashScreenLogo() {
    final String asset = 'assets/peacock.svg';
    final Widget logo = SvgPicture.asset(
      asset,
      semanticsLabel: 'Reog Apps Logo',
    );

    return logo;
  }
}
