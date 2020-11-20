import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

class FavoritesDb {
  static Box _favoritesBox;
  static const _boxNameKey = 'favorites';

  static Future<void> init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _registerAdapter();

    if (_favoritesBox == null) {
      _favoritesBox = await Hive.openBox(_boxNameKey);
    }
  }

  static void _registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
  }

  static void addFavoriteArticle(Article article) {
    openBox();
    _favoritesBox.put(article.id, article);
    _favoritesBox.close();
  }

  static Article getFavoriteArticleById(String id) {
    openBox();
    Article article = _favoritesBox.get(id);
    _favoritesBox.close();
    return article;
  }

  static List<Article> getFavoriteArticles() {
    openBox();
    List<Article> articles = _favoritesBox.toMap().values.toList();
    _favoritesBox.close();
    return articles;
  }

  static void deleteFavoriteArticle(Article article) {
    openBox();
    article.delete();
    _favoritesBox.close();
  }

  static bool isFavoriteArticleExists(String id) {
    openBox();
    bool isExists = _favoritesBox.containsKey(id);
    _favoritesBox.close();
    return isExists;
  }

  static void openBox() async {
    if (!_favoritesBox.isOpen) _favoritesBox = await Hive.openBox(_boxNameKey);
  }
}
