part of 'facts_bloc.dart';

@immutable
abstract class FactsState {}

class FactsInitial extends FactsState {}
class FactsLoading extends FactsState {}
class FactsFailure extends FactsState {
  String message;
  FactsFailure({this.message});
}

class FactsSucceed extends FactsState {
  List<Datum> data;
  FactsSucceed({this.data});
}