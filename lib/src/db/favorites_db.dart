import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/image.dart';
import 'package:reog_apps_flutter/src/utils/article_type.dart';

class FavoritesDb {
  static Box _favoritesBox;
  static Box _articleTypeBox;
  static const _boxNameKey = 'favorites';
  static const _articleTypeBoxNameKey = 'article-type';

  static Future<void> init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _registerAdapter();

    if (_favoritesBox == null) {
      _favoritesBox = await Hive.openBox(_boxNameKey);
    }

    if (_articleTypeBox == null) {
      _articleTypeBox = await Hive.openBox(_articleTypeBoxNameKey);
    }
  }

  static void _registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(ArticleTypeAdapter());
  }

  static void addFavoriteArticle(Article article, ArticleType type) {
    _openFavoriteBox();
    _favoritesBox.put(article.id, article);
    _closeFavoriteBox();
    addFavoriteArticleTypeById(article.id, type);
  }

  static Article getFavoriteArticleById(String id) {
    _openFavoriteBox();
    Article article = _favoritesBox.get(id);
    _closeFavoriteBox();
    return article;
  }

  static List<Article> getFavoriteArticles() {
    _openFavoriteBox();
    List<Article> articles = _favoritesBox.toMap().values.toList();
    _closeFavoriteBox();
    return articles;
  }

  static void deleteFavoriteArticle(Article article) {
    _openFavoriteBox();
    article.delete();
    _closeFavoriteBox();
    deleteFavoriteArticleTypeById(article.id);
  }

  static void deleteFavoriteArticleById(String id) {
    _openFavoriteBox();
    _favoritesBox.delete(id);
    _closeFavoriteBox();
    deleteFavoriteArticleTypeById(id);
  }

  static bool isFavoriteArticleExists(String id) {
    _openFavoriteBox();
    bool isExists = _favoritesBox.containsKey(id);
    _favoritesBox.close();
    return isExists;
  }

  static void addFavoriteArticleTypeById(String id, ArticleType type) {
    _openArticleTypeBox();
    _articleTypeBox.put(id, type);
    _closeArticleTypeBox();
  }

  static ArticleType getFavoriteArticleTypeById(String id) {
    _openArticleTypeBox();
    ArticleType type = _articleTypeBox.get(id);
    _closeArticleTypeBox();
    return type;
  }

  static void deleteFavoriteArticleTypeById(String id) {
    _openArticleTypeBox();
    _articleTypeBox.delete(id);
    _closeArticleTypeBox();
  }

  static void _openFavoriteBox() async {
    if (!_favoritesBox.isOpen) _favoritesBox = await Hive.openBox(_boxNameKey);
  }

  static void _closeFavoriteBox() async {
    if (_favoritesBox.isOpen) _favoritesBox.close();
  }

  static void _openArticleTypeBox() async {
    if (!_articleTypeBox.isOpen)
      _articleTypeBox = await Hive.openBox(_articleTypeBoxNameKey);
  }

  static void _closeArticleTypeBox() async {
    if (_articleTypeBox.isOpen) _articleTypeBox.close();
  }
}
