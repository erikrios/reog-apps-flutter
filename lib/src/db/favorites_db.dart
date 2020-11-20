import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

class FavoritesDb {
  static Box favoritesBox;
  static const _boxNameKey = 'favorites';

  static Future<void> init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _registerAdapter();

    if (favoritesBox == null) {
      favoritesBox = await Hive.openBox(_boxNameKey);
    }
  }

  static void _registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
  }

  static void addFavoriteArticle(Article article) {
    openBox();
    favoritesBox.put(article.id, article);
    favoritesBox.close();
  }

  static Article getFavoriteArticleById(String id) {
    openBox();
    Article article = favoritesBox.get(id);
    favoritesBox.close();
    return article;
  }

  static List<Article> getFavoriteArticles() {
    openBox();
    List<Article> articles = favoritesBox.toMap().values.toList();
    favoritesBox.close();
    return articles;
  }

  static void deleteFavoriteArticle(Article article) {
    openBox();
    article.delete();
    favoritesBox.close();
  }

  static bool isFavoriteArticleExists(String id) {
    openBox();
    bool isExists = favoritesBox.containsKey(id);
    favoritesBox.close();
    return isExists;
  }

  static void openBox() async {
    if (!favoritesBox.isOpen) favoritesBox = await Hive.openBox(_boxNameKey);
  }
}
