import 'package:flutter/material.dart';

class WallpaperItem extends StatelessWidget {
  final String _url;

  WallpaperItem(this._url);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Image.network(
        _url,
        fit: BoxFit.cover,
      ),
    );
  }
}
