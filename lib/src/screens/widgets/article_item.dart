import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class ArticleItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String date;

  ArticleItem({this.image, this.title, this.description, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.0,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: image.isEmpty
                      ? Container(
                          color: Colors.grey,
                          child: Center(child: Text('No Image')),
                        )
                      : image.contains('http')
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                return (loadingProgress == null)
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                              },
                            )
                          : Image.memory(
                              base64Decode(image),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            convertDate(date),
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black26,
            height: 24.0,
          )
        ],
      ),
    );
  }
}
