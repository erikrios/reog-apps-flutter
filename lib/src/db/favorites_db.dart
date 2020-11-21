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
    _openBox();
    _favoritesBox.put(article.id, article);
    _favoritesBox.close();
    _articleTypeBox.put(article.id, type);
    _articleTypeBox.close();
  }

  static Article getFavoriteArticleById(String id) {
    _openBox();
    Article article = _favoritesBox.get(id);
    _favoritesBox.close();
    return article;
  }

  static List<Article> getFavoriteArticles() {
    _openBox();
    List<Article> articles = _favoritesBox.toMap().values.toList();
    _favoritesBox.close();
    return articles;
  }

  static void deleteFavoriteArticle(Article article) {
    _openBox();
    article.delete();
    _favoritesBox.close();
    _articleTypeBox.delete(article.id);
    _articleTypeBox.close();
  }

  static void deleteFavoriteArticleById(String id) {
    _openBox();
    _favoritesBox.delete(id);
    _favoritesBox.close();
    _articleTypeBox.delete(id);
    _articleTypeBox.close();
  }

  static bool isFavoriteArticleExists(String id) {
    _openBox();
    bool isExists = _favoritesBox.containsKey(id);
    _favoritesBox.close();
    return isExists;
  }

  static void _openBox() async {
    if (!_favoritesBox.isOpen) _favoritesBox = await Hive.openBox(_boxNameKey);
    if (!_articleTypeBox.isOpen)
      _articleTypeBox = await Hive.openBox(_articleTypeBoxNameKey);
  }
}
