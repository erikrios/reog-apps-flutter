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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: splashScreenLogo,
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
                  'Reog Apps',
                  style: TextStyle(
                    color: Color(0xffFEE97D),
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
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
