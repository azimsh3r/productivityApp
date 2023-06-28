import 'package:flutter/material.dart';
import 'package:productivityapp/presentation/data/task.dart';
import 'package:productivityapp/presentation/data/taskType.dart';
import 'category.dart';

abstract class DataTasks {
  static List<Category> categories = [
    Category(
      color: Colors.pink,
      title: 'All Tasks',
      iconData: Icons.list_alt_outlined,
      tasks: [],
    ),
    Category(
      color: Colors.blueAccent,
      title: 'Work',
      iconData: Icons.work,
      tasks: [],
    ),
    Category(
      color: Colors.yellowAccent,
      title: 'Personal',
      iconData: Icons.person,
      tasks: [],
    ),
    Category(
      color: Colors.purple,
      title: 'Birthday',
      iconData: Icons.cake_outlined,
      tasks: [],
    ),
    Category(
      color: Colors.green,
      title: 'Wishlist',
      iconData: Icons.format_list_bulleted_outlined,
      tasks: [],
    ),
  ];
  static List<TaskType> taskTypes = [
    TaskType(
      name: 'Previous tasks',
      tasks: [],
    ),
    TaskType(
      name: 'Previous tasks',
      tasks: [],
    ),
    TaskType(
      name: 'Today tasks',
      tasks: [],
    ),
    TaskType(
      name: 'Completed tasks',
      tasks: [],
    ),
  ];
}
