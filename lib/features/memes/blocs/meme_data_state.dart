import 'package:equatable/equatable.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

sealed class MemeDataState extends Equatable {
  const MemeDataState();

  @override
  List<Object?> get props => [];
}

final class MemeInitial extends MemeDataState {}

final class MemeLoading extends MemeDataState {}

final class MemeLoaded extends MemeDataState {
  final List<Meme> memes;
  const MemeLoaded({required this.memes});
  @override
  List<Object> get props => [memes];
}

final class MemeError extends MemeDataState {
  final String message;

  const MemeError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
