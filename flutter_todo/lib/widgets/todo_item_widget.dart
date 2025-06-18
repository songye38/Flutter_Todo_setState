import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_item.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem todo;
  final ValueChanged<TodoItem> onChanged;
  final ValueChanged<TodoItem> onDelete;
  final ValueChanged<TodoItem> onEditTitle;

  const TodoItemWidget({
    required this.todo,
    required this.onChanged,
    required this.onDelete,
    required this.onEditTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.text,
        style: TextStyle(
          fontSize: 18,
          decoration: todo.done
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: todo.done ? Colors.grey : Colors.black,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // 중요! trailing 영역이 넘치지 않도록
        children: [
          Checkbox(
            value: todo.done,
            onChanged: (bool? value) {
              if (value == null) return;
              final updatedTodo = TodoItem(
                id: todo.id,
                text: todo.text,
                done: value,
              );
              onChanged(updatedTodo);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              onDelete(todo); // 부모한테 삭제할 TodoItem 전달
            },
          ),   // 삭제 버튼 추가
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              onEditTitle(todo); // 부모한테 삭제할 TodoItem 전달
            },
          ),// 수정 버튼 추가
        ],
      ),
    );
  }
}
