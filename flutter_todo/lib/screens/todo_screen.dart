
import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import '../services/api_service.dart';
import '../widgets/todo_item_widget.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodosFromServer();
  }

  Future<void> _loadTodosFromServer() async {
    try {
      final fetchedTodos = await ApiService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
      });
    } catch (e) {
      print('Failed to load todos: $e');
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
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTodoToggle(TodoItem updatedTodo) async {
    try {
      final updated = await ApiService.updateIsDone(
        updatedTodo.id,
        updatedTodo.done,
      );
      setState(() {
        final index = todos.indexWhere((t) => t.id == updated.id);
        if (index != -1) {
          todos[index] = updated;
        }
      });
    } catch (e) {
      print('할 일 업데이트 실패: $e');
    }
  }

  void _deleteTodoItem(TodoItem todoToDelete) async {
    try {
      await ApiService.deleteTodo(todoToDelete.id);
      setState(() {
        todos.removeWhere((t) => t.id == todoToDelete.id);
      });
    } catch (e) {
      print('Todo Item 삭제 실패: $e');
    }
  }

  void _editTodoTitle(TodoItem todo) async {
    final TextEditingController editController = TextEditingController(text: todo.text);

    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('할 일 수정'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: InputDecoration(hintText: '새 제목을 입력하세요'),
        ),
        actions: [
          TextButton(
            child: Text('취소'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('저장'),
            onPressed: () => Navigator.of(context).pop(editController.text),
          ),
        ],
      ),
    );

    if (newTitle == null || newTitle.trim().isEmpty) return;

    try {
      final updated = await ApiService.updateTodoTitle(todo.id, newTitle);
      setState(() {
        final index = todos.indexWhere((t) => t.id == todo.id);
        if (index != -1) {
          todos[index] = updated;
        }
      });
    } catch (e) {
      print('Todo 제목 수정 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: todos
                  .map(
                    (todo) => TodoItemWidget(
                      todo: todo,
                      onChanged: _handleTodoToggle,
                      onDelete: _deleteTodoItem,
                      onEditTitle: _editTodoTitle,
                    ),
                  )
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
    );
  }
}
