import 'category.dart';
import 'data_tasks.dart';

class Task {
  Task({
    required this.name,
    required this.time,
  });
  String name;
  DateTime time;
  Category category = DataTasks.categories[0];
}
