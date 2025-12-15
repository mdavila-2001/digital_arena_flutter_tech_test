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
  final bool hasReachedMax;
  final int currentPage;
  final bool isLoadingMore;

  const HomeLoaded({
    required this.characters,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  HomeLoaded copyWith({
    List<CharacterModel>? characters,
    bool? hasReachedMax,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [
    characters,
    hasReachedMax,
    currentPage,
    isLoadingMore,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
