import 'package:flutter/material.dart';

class EditTaskScreen extends StatelessWidget {
  final String initialTask;
  final TextEditingController editTaskController = TextEditingController();

  EditTaskScreen({required this.initialTask}) {
    editTaskController.text = initialTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Edit Task',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 149, 211, 245),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: editTaskController,
                decoration: InputDecoration(labelText: 'Edit Task'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String editedTask = editTaskController.text;
                  Navigator.pop(context, editedTask);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
