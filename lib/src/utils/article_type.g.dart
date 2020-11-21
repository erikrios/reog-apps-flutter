// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleTypeAdapter extends TypeAdapter<ArticleType> {
  @override
  final int typeId = 3;

  @override
  ArticleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ArticleType.news;
      case 1:
        return ArticleType.foods;
      case 2:
        return ArticleType.sites;
      case 3:
        return ArticleType.history;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, ArticleType obj) {
    switch (obj) {
      case ArticleType.news:
        writer.writeByte(0);
        break;
      case ArticleType.foods:
        writer.writeByte(1);
        break;
      case ArticleType.sites:
        writer.writeByte(2);
        break;
      case ArticleType.history:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
