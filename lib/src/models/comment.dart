class Comment {
  String _author;
  String _comment;
  String _url;
  String _date;

  Comment(this._author, this._comment, this._url, this._date);

  String get author => _author;
  String get comment => _comment;
  String get url => _url;
  String get date => _date;
}
