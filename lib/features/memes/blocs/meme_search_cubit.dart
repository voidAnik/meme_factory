import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_factory/features/memes/blocs/meme_data_state.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

class MemeSearchCubit extends Cubit<MemeDataState> {
  MemeSearchCubit() : super(MemeInitial());

  final List<Meme> memeList = [];

  void loadData(List<Meme> memes) {
    memeList.addAll(memes);
  }

  void search({required String query}) {
    if (query.isEmpty) {
      emit(const MemeLoaded(memes: [])); // Show all memes if query is empty
    } else {
      // Filter memes based on the search query
      final filteredMemes = memeList
          .where(
              (meme) => meme.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(MemeLoaded(memes: filteredMemes));
    }
  }

  void reset() {
    emit(MemeInitial());
  }
}
