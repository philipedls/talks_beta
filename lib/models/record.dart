class Record {
  int id;
  String title;
  String content;
  String date;
  Record({this.id, this.title, this.content, this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
    return map;
  }

  Record.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    date = map['date'];
  }
}
