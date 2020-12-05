import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/utils/constants.dart';

class CommentItem extends StatelessWidget {
  final String author;
  final String comment;
  final String date;

  CommentItem(this.author, this.comment, this.date);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Text(
                            author[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(comment),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                convertDate(date),
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Divider(
                              height: 24,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
