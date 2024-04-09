import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todos = <Todo>[];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ..._todos.map(
                (e) => ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.description),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                controller: _descriptionController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _todos.add(
                    Todo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                  );
                });
                _titleController.clear();
                _descriptionController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        )
      ],
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.description,
  });
}
