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
  final Set<int> favoriteIds;
  final String searchQuery;

  const HomeLoaded({
    required this.characters,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.favoriteIds = const {},
    this.searchQuery = '',
  });

  List<CharacterModel> get filteredCharacters {
    if (searchQuery.isEmpty) return characters;
    final query = searchQuery.toLowerCase();
    return characters
        .where(
          (c) =>
              c.name.toLowerCase().contains(query) ||
              c.occupation.toLowerCase().contains(query),
        )
        .toList();
  }

  HomeLoaded copyWith({
    List<CharacterModel>? characters,
    bool? hasReachedMax,
    int? currentPage,
    bool? isLoadingMore,
    Set<int>? favoriteIds,
    String? searchQuery,
  }) {
    return HomeLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [
    characters,
    hasReachedMax,
    currentPage,
    isLoadingMore,
    favoriteIds,
    searchQuery,
  ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
