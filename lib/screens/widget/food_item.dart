import 'dart:convert';

import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final String _image;
  final String _title;

  FoodItem(this._image, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.memory(
            base64Decode(_image),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          FractionallySizedBox(
            heightFactor: 0.2,
            widthFactor: 1.0,
            child: Container(
              color: Color(0x7f000000),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Text(
                _title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
