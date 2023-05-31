import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:productivityapp/presentation/data/data_tasks.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  void addCategoryTasks({required String title}) {
    if (title.isNotEmpty) {
      DatabaseTasks.categories.add(
        Category(
          name: title,
          tasks: [],
        ),
      );
      emit(CategoryAdded());
    }
  }
}
