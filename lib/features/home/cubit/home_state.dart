import 'package:equatable/equatable.dart';
import '../../../data/models/character_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CharacterModel> characters;

  const HomeLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
