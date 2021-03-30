import 'package:flutter/material.dart';

import 'todo.dart';

class EditDialog extends StatelessWidget {
  static Future<Todo> show(BuildContext context, [Todo? base]) async {
    return (await showDialog<Todo>(
      context: context,
      builder: (context) => EditDialog._(base: base,),
    ))!;
  }

  final Todo? base;

  EditDialog._({
    this.base,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _EditForm(
        base: base,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, Todo(title: "hoge"));
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}

class _EditForm extends StatefulWidget {
  final Todo? base;

  _EditForm({
    this.base,
    Key? key,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.base?.title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "TODO"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
