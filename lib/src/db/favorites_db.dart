import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reog_apps_flutter/src/models/article.dart';
import 'package:reog_apps_flutter/src/models/image.dart';

class FavoritesDb {
  static Future<void> init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _registerAdapter();
  }

  static void _registerAdapter() {
    Hive.registerAdapter(ImageAdapter());
    Hive.registerAdapter(ArticleAdapter());
  }
}
