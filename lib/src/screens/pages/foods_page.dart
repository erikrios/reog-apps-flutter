import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:reog_apps_flutter/src/bloc/events/foods_result_event.dart';
import 'package:reog_apps_flutter/src/bloc/foods_result_bloc.dart';
import 'package:reog_apps_flutter/src/bloc/states/foods_result_state.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/articles.dart';
import 'package:reog_apps_flutter/src/screens/pages/details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/food_item.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class FoodsPage extends StatefulWidget {
  @override
  _FoodsPageState createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  FoodsResultBloc _bloc;
  int _currentPage = 1;
  int _totalPage = 1;
  final int _limit = 5;
  Articles foods;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<FoodsResultBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBlocBuilder(_bloc);
  }

  Widget _buildBlocBuilder(FoodsResultBloc bloc) {
    return BlocBuilder<FoodsResultBloc, FoodsResultState>(
      cubit: bloc,
      builder: (BuildContext context, FoodsResultState state) {
        if (state is FoodsResultInitialState) {
          bloc.add(FoodsResultFetching(page: _currentPage, limit: _limit));
          return Container();
        } else if (state is FoodsResultLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FoodsResultErrorState) {
          return RefreshIndicator(
            onRefresh: () {
              bloc.add(FoodsResultFetching(page: 1, limit: _limit));
              return;
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(state.error),
                ),
              ),
            ),
          );
        } else {
          return _buildFoodsResult(state);
        }
      },
    );
  }

  Widget _buildFoodsResult(FoodsResultState state) {
    if (state is FoodsResultSuccessState) {
      foods = state.foodsResult.data[0];
      _currentPage = state.foodsResult.data[0].currentPage;
      _totalPage = state.foodsResult.data[0].totalPages;
    }

    return Container(
        child: foods.articles.isEmpty
            ? Center(
                child: Text('Foods is empty.'),
              )
            : LazyLoadScrollView(
                onEndOfPage: _loadMoreData,
                child: RefreshIndicator(
                  onRefresh: () {
                    _bloc.add(FoodsResultFetching(page: 1, limit: _limit));
                    return;
                  },
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        padding: EdgeInsets.all(3.0),
                        itemCount: foods.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: FoodItem(
                                foods.articles[index].images.isEmpty
                                    ? ""
                                    : foods.articles[index].images[0].image,
                                foods.articles[index].title ?? ""),
                            onTap: () {
                              _navigateToDetails(
                                  context: context,
                                  article: foods.articles[index]);
                            },
                          );
                        },
                      ),
                      (state is FoodsResultLoadingMoreState)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ));
  }

  void _loadMoreData() {
    if (_currentPage < _totalPage) {
      _currentPage++;
      _bloc.add(FoodsResultFetchingMore(page: _currentPage, limit: _limit));
    }
  }

  void _navigateToDetails(
      {@required BuildContext context, Article article}) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(article, ArticleType.foods);
    }));

    print(result);
  }
}
