import 'package:flutter/material.dart';
import 'models/todo_item.dart';
import 'widgets/todo_item_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final todos = [
    TodoItem(id: 1, text: '첫 번째 할 일'),
    TodoItem(id: 2, text: '두 번째 할 일'),
    TodoItem(id: 3, text: '세 번째 할 일'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Todo App')),
        body: ListView(
          children: todos.map((todo) => TodoItemWidget(todo: todo)).toList(),
        ),
      ),
    );
  }
}
