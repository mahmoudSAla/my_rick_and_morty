part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class DataLoaded extends HomeState {
  final List<CharacterModel> characters ;

  DataLoaded({required this.characters});
}


class SearchState extends HomeState {
  final bool searchState ;

  SearchState({required this.searchState});
}


