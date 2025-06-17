import 'package:flutter/material.dart';
import 'models/todo_item.dart';
import 'services/api_service.dart';
import 'widgets/todo_item_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<TodoItem> todos = []; // 초기값 비워둠
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodosFromServer(); // 앱 시작 시 서버 데이터 불러오기
  }

  Future<void> _loadTodosFromServer() async {
    try {
      final fetchedTodos = await ApiService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
      });
    } catch (e) {
      print('Failed to load todos: $e');
      // 에러 처리: 토스트 띄우거나 등등
    }
  }

  void _addTodo() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    try {
      final newTodo = await ApiService.addTodo(text);
      setState(() {
        todos.add(newTodo);
        _controller.clear();
      });
    } catch (e) {
      print('Failed to add todo: $e');
      // 에러 처리
    }
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
