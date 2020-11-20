import 'package:hive/hive.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

class FavoritesDb {
  static void registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
  }
}
