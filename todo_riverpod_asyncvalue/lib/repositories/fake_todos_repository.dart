import 'dart:math';

import '../models/todo_model.dart';
import 'todos_repository.dart';

final List<Map<String, dynamic>> initialTodos = [
  {"id": "1", "desc": "Clean the room", "completed": false},
  {"id": "2", "desc": "Wash the dise", "completed": false},
  {"id": "3", "desc": "Do homework", "completed": false},
];

const double kProbabilityOfError = 0.5;
const int kDelayDuration = 1;

class FakeTodosRepository extends TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initialTodos;
  final Random random = Random();

  Future<void> waitSeconds() {
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Todo>> getTodos() async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw "Fail to retrive todos";
      }

      return [for (final todo in fakeTodos) Todo.fromJson(todo)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw "Fail to add todo";
      }

      fakeTodos = [...fakeTodos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw "Fail to add todo";
      }

      fakeTodos.removeWhere((todo) => todo['id'] == id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw "Fail to edit todo";
      }

      final index = fakeTodos.indexWhere((todo) => todo['id'] == id);
      if (index != -1) {
        fakeTodos[index] = {
          'id': id,
          'desc': desc,
          'completed': fakeTodos[index]['completed'],
        };
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSeconds();

    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw "Fail to toggle todo";
      }

      final index = fakeTodos.indexWhere((todo) => todo['id'] == id);
      if (index != -1) {
        fakeTodos[index] = {
          'id': id,
          'desc': fakeTodos[index]["desc"],
          'completed': !fakeTodos[index]['completed'],
        };
      }
    } catch (e) {
      rethrow;
    }
  }
}
