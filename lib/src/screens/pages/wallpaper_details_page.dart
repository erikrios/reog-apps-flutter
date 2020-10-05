import 'package:flutter/material.dart';

class WallpaperDetailsPage extends StatefulWidget {
  final String _url;
  WallpaperDetailsPage(this._url);
  @override
  _WallpaperDetailsPageState createState() => _WallpaperDetailsPageState(_url);
}

class _WallpaperDetailsPageState extends State<WallpaperDetailsPage> {
  final String _url;
  _WallpaperDetailsPageState(this._url);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _navigateBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                _navigateBack();
              }),
          title: Text('Wallpaper'),
        ),
      ),
    );
  }

  void _navigateBack() {
    Navigator.pop(context, true);
  }
}
