import 'package:flutter/material.dart';
import 'models/todo_item.dart';
import 'widgets/todo_item_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<TodoItem> todos = [
    TodoItem(id: 1, text: '첫 번째 할 일'),
    TodoItem(id: 2, text: '두 번째 할 일'),
    TodoItem(id: 3, text: '세 번째 할 일'),
  ];

  final TextEditingController _controller = TextEditingController();
  int _nextId = 4;

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      todos.add(TodoItem(id: _nextId++, text: text));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Todo App')),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: todos
                    .map((todo) => TodoItemWidget(todo: todo))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: '새 할 일 입력',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addTodo(),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(onPressed: _addTodo, child: Text('추가')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
