import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/article_details_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/events/article_details_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/states/article_details_result_state.dart';
import 'package:reog_apps_flutter/src/db/favorites_db.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/comment.dart';
import 'package:reog_apps_flutter/src/screens/widgets/comment_item.dart';
import 'package:reog_apps_flutter/src/screens/widgets/main_pop_up_menu.dart';
import 'package:reog_apps_flutter/src/service/reog_apps_service.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class DetailsPage extends StatefulWidget {
  final Article _article;
  final ArticleType _type;

  DetailsPage(this._article, this._type);

  @override
  _DetailsPageState createState() => _DetailsPageState(_article, _type);
}

class _DetailsPageState extends State<DetailsPage> {
  ScrollController _scrollViewController;
  final Article _article;
  final ArticleType _type;
  bool _isBookmarked;
  int _selectedNavBar = 0;
  int _currentSliderIndex = 0;
  ArticleDetailsResultBloc _bloc;

  _DetailsPageState(this._article, this._type);

  @override
  void initState() {
    super.initState();
    _isBookmarked = FavoritesDb.isFavoriteArticleExists(_article.id);
    _scrollViewController = ScrollController();
    _isBookmarked = false;
    _bloc = ArticleDetailsResultBloc(
        service: ReogAppsService.create(), type: _type);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBar =
        BlocBuilder<ArticleDetailsResultBloc, ArticleDetailsResultState>(
      cubit: _bloc,
      builder: (BuildContext context, ArticleDetailsResultState state) {
        return BottomNavigationBar(
          selectedItemColor: Color(0xff66A84D),
          unselectedItemColor: Color(0xff66A84D),
          currentIndex: _selectedNavBar,
          onTap: onNavBarTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: (_isBookmarked)
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border),
                label: (_isBookmarked)
                    ? 'remove_bookmark'.tr()
                    : 'add_bookmark'.tr()),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 25.toString(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              label: (state is ArticleDetailsResultSuccessState)
                  ? state.articleDetailsResult.data[0].views.toString()
                  : "-",
            )
          ],
        );
      },
    );

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        _navigateBack();
      },
      child: Scaffold(
        body: BlocBuilder<ArticleDetailsResultBloc, ArticleDetailsResultState>(
          cubit: _bloc,
          builder: (BuildContext context, ArticleDetailsResultState state) {
            if (state is ArticleDetailsResultInitialState) {
              _bloc.add(ArticleDetailsResultFetching(id: _article.id));
              return SizedBox();
            } else {
              return NestedScrollView(
                controller: _scrollViewController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
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
                        title: Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            (state is ArticleDetailsResultSuccessState)
                                ? state.articleDetailsResult.data[0].title
                                : "",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                        titlePadding: EdgeInsetsDirectional.only(
                            start: 50, end: 16, bottom: 16),
                        background: Container(
                          color: Colors.black,
                          child: Stack(
                            children: <Widget>[
                              CarouselSlider(
                                items: (state
                                        is ArticleDetailsResultSuccessState)
                                    ? _article.images.map((image) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Image.network(
                                            image.image,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }).toList()
                                    : [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                        )
                                      ],
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentSliderIndex == index
                                            ? Color.fromRGBO(255, 255, 255, 0.9)
                                            : Color.fromRGBO(
                                                255, 255, 255, 0.4),
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
                  child: (state is ArticleDetailsResultSuccessState)
                      ? Text(
                          state.articleDetailsResult.data[0].description,
                          textAlign: TextAlign.justify,
                        )
                      : Container(
                          child: Center(
                            child: (state is ArticleDetailsResultLoadingState)
                                ? CircularProgressIndicator()
                                : Text((state as ArticleDetailsResultErrorState)
                                    .error),
                          ),
                        ),
                ),
              );
            }
          },
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
              FavoritesDb.deleteFavoriteArticleById(_article.id);
              print('bookmark_removed'.tr());
            } else {
              _isBookmarked = true;
              FavoritesDb.addFavoriteArticle(_article, _type);
              print('bookmark_added'.tr());
            }
          }
          break;
        case 1:
          {
            List<Comment> comments = new List<Comment>();
            for (int i = 0; i < 30; i++) {
              if (i % 2 == 0)
                comments.add(new Comment(
                    'Author Name $i',
                    '$i Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea',
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_Earth_seen_from_Apollo_17.jpg/800px-The_Earth_seen_from_Apollo_17.jpg',
                    'Tue, $i Oct 20 08:50 pm'));
              else
                comments.add(new Comment(
                    'Author Name $i',
                    '$i Lorem ipsum dolor sit amet dolore magna aliqua. Sed do eiusmod tempor.',
                    'https://archive.org/download/shimla_phoenix_K011P-01c_panelscan/Fromental_Conversational/F006-willow-with-embroidery-col-custom.jpg',
                    'Tue, $i Oct 20 08:50 pm'));
            }

            TextEditingController controller = TextEditingController();

            showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (builder) {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          width: 100,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CommentItem(
                                  comments[index].author,
                                  comments[index].comment,
                                  comments[index].url,
                                  comments[index].date);
                            },
                            itemCount: 30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8.0),
                                child: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    print('Send');
                                  },
                                ),
                              ),
                              hintText: 'Type your comment...',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
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
