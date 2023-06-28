import 'package:flutter/material.dart';
import 'package:productivityapp/presentation/data/task.dart';

class Category {
  Category({
    required this.color,
    required this.title,
    this.iconData,
    required this.tasks,
  });
  Color color;
  String title;
  IconData? iconData;
  List<Task> tasks;
}
