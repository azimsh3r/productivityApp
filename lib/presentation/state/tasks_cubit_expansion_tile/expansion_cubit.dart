import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:productivityapp/presentation/data/data_tasks.dart';

import '../../data/taskType.dart';

part 'expansion_state.dart';

class ExpansionCubit extends Cubit<ExpansionState> {
  ExpansionCubit() : super(ExpansionInitial());

  int expandedIndex = -3;
  List<int> openTilesIndexes = [];
  List<int> seeMore = [];

  showMore({required int index}) {
    seeMore.add(index);
    emit(ExpansionShowAll());
  }

  void expand({required int index}) {
    expandedIndex = index;
    openTilesIndexes.add(index);
    emit(ExpansionChanged());
  }

  void clearTile(int currentIndex) {
    openTilesIndexes.remove(currentIndex);
    seeMore.remove(currentIndex);
    expandedIndex = -3;
    emit(ExpansionChanged());
  }

  void addCategoryTasks({required String title}) {
    if (title.isNotEmpty) {
      DataTasks.taskTypes.add(
        TaskType(
          name: title,
          tasks: [],
        ),
      );
    }
    emit(ExpansionChanged());
  }
}
