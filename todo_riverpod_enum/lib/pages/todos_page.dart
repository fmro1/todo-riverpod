import 'package:flutter/material.dart';
import 'package:todo_riverpod/pages/widgets/filter_todo.dart';
import 'package:todo_riverpod/pages/widgets/new_todo.dart';
import 'package:todo_riverpod/pages/widgets/search_todo.dart';
import 'package:todo_riverpod/pages/widgets/show_todos.dart';
import 'package:todo_riverpod/pages/widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TodoHeader(),
              NewTodo(),
              SearchTodo(),
              FilterTodo(),
              SizedBox(height: 10),
              Expanded(child: ShowTodos()),
            ],
          ),
        ),
      ),
    );
  }
}
