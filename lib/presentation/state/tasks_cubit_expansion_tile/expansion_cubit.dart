import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'expansion_state.dart';

class ExpansionCubit extends Cubit<ExpansionState> {
  ExpansionCubit() : super(ExpansionInitial());
  int ExpandedIndex = -1;
  void expand({required int index}) {
    ExpandedIndex = index;
    emit(ExpansionChanged());
  }

  void clear() {
    ExpandedIndex = -1;
    emit(ExpansionChanged());
  }
}
