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
      _favoritesBox.clear();
    }

    if (_articleTypeBox == null) {
      _articleTypeBox = await Hive.openBox(_articleTypeBoxNameKey);
      _articleTypeBox.clear();
    }
  }

  static void _registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(ArticleTypeAdapter());
  }

  static void addFavoriteArticle(Article article, ArticleType type) {
    _favoritesBox.put(article.id, article);
    addFavoriteArticleTypeById(article.id, type);
  }

  static Article getFavoriteArticleById(String id) {
    Article article = _favoritesBox.get(id);
    return article;
  }

  static List<Article> getFavoriteArticles() {
    List<Article> articles = _favoritesBox.toMap().values.toList();
    return articles;
  }

  static void deleteFavoriteArticle(Article article) {
    article.delete();
    deleteFavoriteArticleTypeById(article.id);
  }

  static void deleteFavoriteArticleById(String id) {
    _favoritesBox.delete(id);
    deleteFavoriteArticleTypeById(id);
  }

  static bool isFavoriteArticleExists(String id) {
    bool isExists = _favoritesBox.containsKey(id);
    return isExists;
  }

  static void addFavoriteArticleTypeById(String id, ArticleType type) {
    _articleTypeBox.put(id, type);
  }

  static ArticleType getFavoriteArticleTypeById(String id) {
    ArticleType type = _articleTypeBox.get(id);
    return type;
  }

  static void deleteFavoriteArticleTypeById(String id) {
    _articleTypeBox.delete(id);
  }
}
