// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_item.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080'; // 서버 주소

  // 할 일 목록 불러오기
  static Future<List<TodoItem>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => TodoItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // 할 일 추가하기
  static Future<TodoItem> addTodo(String task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': task}),
    );

    if (response.statusCode == 201) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  // 할 일 is_done 상태 수정하기
  static Future<TodoItem> updateIsDone(int id, bool isDone) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'is_done': isDone}),
    );

    if (response.statusCode == 200) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  static Future<TodoItem> updateTodoTitle(int id, String TodoTitle) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': TodoTitle}),
    );

    if (response.statusCode == 200) {
      return TodoItem.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
