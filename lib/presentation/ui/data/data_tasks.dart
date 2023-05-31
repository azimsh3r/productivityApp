class DatabaseTasks {
  static List<Category> categories = [
    Category(
      name: 'Categories',
      tasks: [
        Task(name: 'Do the Job', time: DateTime(2022, 12, 29)),
        Task(name: 'Go sleep', time: DateTime(2022)),
        Task(name: 'Do the Job', time: DateTime(2022, 12, 29)),
        Task(name: 'Go sleep', time: DateTime(2022)),
        Task(name: 'Do the Job', time: DateTime(2022, 12, 29)),
        Task(name: 'Go sleep', time: DateTime(2022)),
      ],
    ),
    Category(
      name: 'Previous tasks',
      tasks: [
        Task(name: 'Do the Job', time: DateTime(2022)),
        Task(name: 'Go sleep', time: DateTime(2022)),
      ],
    ),
    Category(
      name: 'Previous tasks',
      tasks: [
        Task(name: 'Do the Job2', time: DateTime(2022)),
        Task(name: 'Go sleep2', time: DateTime(2022)),
      ],
    ),
    Category(
      name: 'Today tasks',
      tasks: [
        Task(name: 'Do the Job3', time: DateTime(2022)),
        Task(name: 'Go sleep3', time: DateTime(2022)),
      ],
    ),
    Category(
      name: 'Completed tasks',
      tasks: [
        Task(name: 'Do the Job4', time: DateTime(2022)),
        Task(name: 'Go sleep4', time: DateTime(2022)),
      ],
    ),
  ];
}

class Task {
  Task({
    required this.name,
    required this.time,
  });
  String name;
  DateTime time;
}

class Category {
  Category({
    required this.name,
    required this.tasks,
  });
  String name;
  List<Task> tasks;
}
