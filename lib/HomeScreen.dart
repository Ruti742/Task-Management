import 'package:flutter/material.dart';
import 'EditTask.dart';
import 'State.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({required this.username});
  List<String> tasksDone=[];
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<String> tasksDone=[];
  TextEditingController tasksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Task Management',
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
              Text(
                'Welcome, ${widget.username}!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16.0),
              Text('Here you will organize your tasks for the day'),
              SizedBox(height: 16.0),
              Text(
                'Your Tasks:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              StoreConnector<List<String>, List<String>>(
                converter: (store) => store.state,
                builder: (context, tasks) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(tasks[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _editTask(context, index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _removeTask(context, index);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    _completeTask(context, index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Tasks Done:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: tasksDone.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.blue, 
                      child: ListTile(
                        title: Text(tasksDone[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _removeCompletedTask(context, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              
              TextField(
                controller: tasksController, 
                onSubmitted: (newTask) {
                  _addTask(context, newTask);
                },
                decoration: InputDecoration(
                  labelText: 'Add a new task',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      String newTask = tasksController.text;
                      _addTask(context, newTask);
                      tasksController.clear(); 
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _editTask(BuildContext context, int index) async {
    String editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(initialTask: store.state[index]),
      ),
    );

    if (editedTask != null) {
      store.dispatch(EditTaskAction(index, editedTask));
    }
  }
  void _removeCompletedTask(BuildContext context, int index) {
  setState(() {
    tasksDone.removeAt(index);
  });
}
  void _removeTask(BuildContext context, int index) {
    store.dispatch(RemoveTaskAction(index));
  }

  void _completeTask(BuildContext context, int index) {

    String completedTask = store.state[index];
    setState(() {
    tasksDone.add(completedTask);
    });
    
    store.dispatch(CompleteTaskAction(index));
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task done!'),
          content: Text('You are amazing, you managed to finish the task'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Thanks'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(BuildContext context, String newTask) {
    store.dispatch(AddTaskAction(newTask));
    
  }
}

