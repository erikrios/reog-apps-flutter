import 'package:hive/hive.dart';

part 'article_type.g.dart';

@HiveType(typeId: 3)
enum ArticleType {
  @HiveField(0)
  news,
  @HiveField(1)
  foods,
  @HiveField(2)
  sites,
  @HiveField(3)
  history,
}
