
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_item.dart';


class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;

  const TodoItemWidget({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.text,
        style: TextStyle(
          fontSize: 18,
          decoration: todo.done ? TextDecoration.lineThrough : TextDecoration.none,
          color: todo.done ? Colors.grey : Colors.black,
        ),
      ),
      trailing: Checkbox(
        value: todo.done,
        onChanged: (bool? value) {
          // 여기서는 StatelessWidget이라 상태 변경은 안 되지만,
          // 실제 앱에서는 StatefulWidget으로 바꾸거나 상태관리 쓰는게 좋아
        },
      ),
    );
  }
}
