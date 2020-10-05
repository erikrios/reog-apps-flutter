class Article {
  String _id;
  String _title;
  String _description;
  String _date;
  int _views;
  List<String> _images;

  Article(this._id, this._title, this._description, this._date, this._views,
      this._images);

  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get views => _views;
  List<String> get images => _images;
}
