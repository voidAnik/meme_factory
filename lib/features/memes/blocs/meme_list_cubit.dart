import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_factory/core/error/failures.dart';
import 'package:meme_factory/features/memes/blocs/meme_data_state.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:meme_factory/features/memes/data/repositories/meme_list_repository.dart';

class MemeListCubit extends Cubit<MemeDataState> {
  MemeListCubit(this.repository) : super(MemeInitial());

  final MemeListRepository repository;

  List<Meme> allMemes = [];
  List<Meme> displayedMemes = [];

  final int memesToLoad = 10;

  void getMemes() async {
    emit(MemeLoading());

    final Either<Failure, List<Meme>> failureOrResponse =
        await repository.getMemes();

    failureOrResponse.fold((failure) {
      if (failure is ServerFailure) {
        emit(MemeError(message: failure.error));
      } else {
        emit(const MemeError(message: 'Unknown Exception'));
      }
    }, (response) {
      // Store all memes and load the first batch for pagination
      allMemes = response; // Store all memes
      displayedMemes =
          allMemes.take(memesToLoad).toList(); // Load the first set
      log('display memes: $displayedMemes');
      emit(MemeLoaded(memes: List<Meme>.from(displayedMemes)));
    });
  }

  void loadMoreMemes() {
    log('loading more item');
    if (displayedMemes.length < allMemes.length) {
      final int nextIndex = displayedMemes.length;
      final List<Meme> nextMemes =
          allMemes.skip(nextIndex).take(memesToLoad).toList();

      displayedMemes.addAll(nextMemes);
      log('display memes: $displayedMemes');
      emit(MemeLoaded(memes: List<Meme>.from(displayedMemes)));
    }
  }
}
