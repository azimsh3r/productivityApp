import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  int activeIndex = 0;
  void changeActive(int currentIndex) {
    activeIndex = currentIndex;
    emit(NavigationChanged());
  }

  void addTask() {}
}
