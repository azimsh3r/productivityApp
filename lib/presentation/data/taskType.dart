import 'package:productivityapp/presentation/data/task.dart';

class TaskType {
  TaskType({
    required this.name,
    required this.tasks,
  });
  String name;
  List<Task> tasks;
}
