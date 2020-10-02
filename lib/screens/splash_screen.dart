import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final SplashScreenLogo splashScreenLogo = SplashScreenLogo();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Color(0xff97DA7B),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(58.0),
            child: splashScreenLogo,
          ),
        ),
      ),
    );
  }
}

class SplashScreenLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String asset = 'assets/peacock.svg';
    final Widget logo = SvgPicture.asset(
      asset,
      semanticsLabel: 'Reog Apps Logo',
    );
    return logo;
  }
}
