import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'widgets/filter_todo.dart';
import 'widgets/new_todo.dart';
import 'widgets/search_todo.dart';
import 'widgets/show_todos.dart';
import 'widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoaderOverlay(
          overlayWholeScreen: true,
          overlayWidgetBuilder: (_) {
            return const Center(
              child: SpinKitFadingCircle(color: Colors.grey),
            );
          },
          child: Padding(
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
      ),
    );
  }
}
