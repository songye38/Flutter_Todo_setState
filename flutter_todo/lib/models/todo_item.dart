class TodoItem {
  final int id;
  final String text;
  bool done;

  TodoItem({
    required this.id,
    required this.text,
    this.done = false,
  });

  // JSON → TodoItem
  // fromJson → JSON을 TodoItem 객체로 바꾸는 함수
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      text: json['title'], // 서버에서는 'title'이라는 키를 씀
      done: json['is_done'] ?? false,
    );
  }

  // TodoItem → JSON
  // toJson → TodoItem 객체를 JSON으로 바꾸는 함수
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': text,       // 서버는 'title' 키를 원함
      'is_done': done,
    };
  }
}
