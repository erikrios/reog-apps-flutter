import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';

class DetailsPage extends StatefulWidget {
  final Article _article;

  DetailsPage(this._article);

  @override
  _DetailsPageState createState() => _DetailsPageState(_article);
}

class _DetailsPageState extends State<DetailsPage> {
  ScrollController _scrollViewController;
  final Article _article;
  bool _isBookmarked;
  int _selectedNavBar = 0;
  int _currentSliderIndex = 0;

  _DetailsPageState(this._article);

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

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _navigateBack();
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    _navigateBack();
                  },
                ),
                actions: <Widget>[
                  MainPopUpMenu(true),
                ],
                expandedHeight: 56.0 * 3.5,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    _article.title,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13.0),
                  ),
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 50, end: 8, bottom: 16),
                  background: Container(
                    color: Colors.black,
                    child: Stack(
                      children: <Widget>[
                        CarouselSlider(
                          items: _article.images.map((image) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.memory(
                                base64Decode(image),
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              height: MediaQuery.of(context).size.height,
                              enableInfiniteScroll: false,
                              autoPlayInterval: Duration(seconds: 5),
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentSliderIndex = index;
                                });
                              }),
                        ),
                        Align(
                          alignment: Alignment(0, 0.9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _article.images.map((image) {
                              int index = _article.images.indexOf(image);
                              return Container(
                                width: 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentSliderIndex == index
                                      ? Color.fromRGBO(255, 255, 255, 0.9)
                                      : Color.fromRGBO(255, 255, 255, 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Text(
              _article.description,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        bottomNavigationBar: _bottomNavBar,
      ),
    );
  }

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

  void _navigateBack() {
    Navigator.pop(context, true);
  }
}
