import 'dart:convert';

import 'package:flutter/material.dart';

class SitesItem extends StatelessWidget {
  final String _image;
  final String _title;

  SitesItem(this._image, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Image.memory(
            base64Decode(_image),
            fit: BoxFit.cover,
          ),
          Container(
            color: Color(0x4c000000),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              _title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
