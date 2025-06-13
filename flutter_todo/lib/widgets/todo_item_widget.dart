
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_item.dart';



class TodoItemWidget extends StatelessWidget{
  final TodoItem todo;

  const TodoItemWidget({required this.todo, super.key});

  @override
  Widget build(BuildContext context){
    return ListTile(
      title : Text(
        todo.text,
        style : TextStyle(fontSize:18),
      ),
    );
  }
}