import 'package:redux/redux.dart'; 


class AddTaskAction {
  final String payload;
  AddTaskAction(this.payload);
}

class EditTaskAction {
  final int index;
  final String payload;
  EditTaskAction(this.index, this.payload);
}

class CompleteTaskAction {
  final int index;
  CompleteTaskAction(this.index);
}

class RemoveTaskAction {
  final int index;
  RemoveTaskAction(this.index);
}


List<String> tasksReducer(List<String> state, dynamic action) {
  if (action is AddTaskAction) {
    return List.from(state)..add(action.payload);
  } else if (action is EditTaskAction) {
    return List.from(state)..[action.index] = action.payload;
  } else if (action is RemoveTaskAction) {
    return List.from(state)..removeAt(action.index);
  } else if (action is CompleteTaskAction) {
    int index = action.index;
    return List.from(state)..removeAt(index);
  }
  return state;
}


final store = Store<List<String>>(
  tasksReducer,
  initialState: [],
);
