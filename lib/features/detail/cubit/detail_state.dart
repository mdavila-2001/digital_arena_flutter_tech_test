import 'package:equatable/equatable.dart';
import '../../../data/models/character_detail_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final CharacterDetailModel character;
  const DetailLoaded(this.character);
  @override
  List<Object> get props => [character];
}

class DetailError extends DetailState {
  final String message;
  const DetailError(this.message);
  @override
  List<Object> get props => [message];
}