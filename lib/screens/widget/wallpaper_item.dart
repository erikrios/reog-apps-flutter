import 'dart:convert';

import 'package:flutter/material.dart';

class WallpaperItem extends StatelessWidget {
  final String _image;

  WallpaperItem(this._image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      child: Image.memory(
        base64Decode(_image),
        fit: BoxFit.cover,
      ),
    );
  }
}
