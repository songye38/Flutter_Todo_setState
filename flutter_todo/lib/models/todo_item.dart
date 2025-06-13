class TodoItem {
  final int id;
  final String text;
  bool done;

  TodoItem({
    required this.id,
    required this.text,
    this.done = false,
  });
}
