import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/models/article.dart';

class Details extends StatefulWidget {
  final Article _article;

  Details(this._article);

  @override
  _DetailsState createState() => _DetailsState(_article);
}

class _DetailsState extends State<Details> {
  ScrollController _scrollViewController;
  final Article _article;
  bool _isBookmarked;
  int _selectedNavBar = 0;

  _DetailsState(this._article);

  void onNavBarTapped(int index) {
    setState(() {
      _selectedNavBar = index;
      switch (_selectedNavBar) {
        case 0:
          {
            if (_isBookmarked) {
              _isBookmarked = false;
              print('Bookmark removed');
            } else {
              _isBookmarked = true;
              print('Bookmard added');
            }
          }
          break;
        case 1:
          print('Show comments');
          break;
        default:
          print('Show viewers');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _isBookmarked = false;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: (_isBookmarked)
              ? Icon(Icons.bookmark)
              : Icon(Icons.bookmark_border),
          label: (_isBookmarked) ? 'Remove Bookmark' : 'Add Bookmark'),
      BottomNavigationBarItem(
        icon: Icon(Icons.comment),
        label: 25.toString(),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.remove_red_eye),
        label: _article.views.toString(),
      )
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      selectedItemColor: Color(0xff66A84D),
      unselectedItemColor: Color(0xff66A84D),
      currentIndex: _selectedNavBar,
      onTap: onNavBarTapped,
    );

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              leading: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              expandedHeight: 56.0 * 4.5,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  _article.title,
                  overflow: TextOverflow.ellipsis,
                ),
                background: Container(
                  color: Colors.black,
                  child: Image.memory(
                    base64Decode(_article.images[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Text(
            _article.description,
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
