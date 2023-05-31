part of 'expansion_cubit.dart';

@immutable
abstract class ExpansionState {}

class ExpansionInitial extends ExpansionState {}

class ExpansionChanged extends ExpansionState {}

class ExpansionShowAll extends ExpansionState {}
