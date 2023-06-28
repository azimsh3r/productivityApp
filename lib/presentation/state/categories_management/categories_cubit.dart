import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productivityapp/presentation/data/data_tasks.dart';
import 'package:productivityapp/presentation/ui/resources/app_colors.dart';

import '../../data/category.dart';
import '../../data/task.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void addCategory({required String title}) {
    if (title.isNotEmpty) {
      DataTasks.categories.add(
        Category(
          title: title,
          color: AppColors.enabledPurple,
          tasks: [],
        ),
      );
      emit(CategoryAdded());
    }
  }

  void addTask({
    required String title,
    required DateTime time,
  }) {
    if (title.isNotEmpty) {
      DataTasks.taskTypes[2].tasks.add(
        Task(
          name: title,
          time: time,
        ),
      );
      emit(TaskAdded());
    }
  }
}
