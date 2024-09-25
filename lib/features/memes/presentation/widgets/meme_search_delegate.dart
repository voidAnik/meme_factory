import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meme_factory/core/constants/strings.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/widgets/error_widget.dart';
import 'package:meme_factory/features/meme_detail/presentation/pages/meme_details_page.dart';
import 'package:meme_factory/features/memes/blocs/meme_data_state.dart';
import 'package:meme_factory/features/memes/blocs/meme_search_cubit.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:meme_factory/features/memes/presentation/widgets/meme_list_tile_widget.dart';
import 'package:meme_factory/features/memes/presentation/widgets/shimmer_list_item.dart';

class MemeSearchDelegate extends SearchDelegate<Meme> {
  final MemeSearchCubit _searchCubit;

  MemeSearchDelegate(this._searchCubit);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _searchCubit.reset(); // Clear query and reset search results
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchBody(); // Build results from the search cubit state
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      _searchCubit.search(query: query);
    } else {
      _searchCubit.reset();
    }

    return _searchBody();
  }

  BlocBuilder<MemeSearchCubit, MemeDataState> _searchBody() {
    return BlocBuilder<MemeSearchCubit, MemeDataState>(
      bloc: _searchCubit,
      builder: (context, state) {
        if (state is MemeLoading) {
          return _createShimmerList(5);
        } else if (state is MemeLoaded) {
          final List<Meme> memes = state.memes;

          if (memes.isEmpty) {
            return const ErrorMessage(
              message: AppStrings.noMeme,
            );
          }
          return _createSearchList(memes);
        } else if (state is MemeError) {
          return ErrorMessage(message: state.message);
        } else {
          return _searchMessage(context, AppStrings.searchHint);
        }
      },
    );
  }

  ListView _createSearchList(List<Meme> memes) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: memes.length,
      itemBuilder: (context, index) {
        final meme = memes[index];
        return MemeListTileWidget(
          onPressed: () {
            _navigateToMemeDetailPage(context, meme: meme);
          },
          meme: meme,
        );
      },
    );
  }

  ListView _createShimmerList(int length) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: length,
      itemBuilder: (context, index) {
        return const ShimmerListItem();
      },
    );
  }

  Widget _searchMessage(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.textStyle.titleMedium,
        ),
      ),
    );
  }

  void _navigateToMemeDetailPage(BuildContext context, {required Meme meme}) {
    context.push(MemeDetailsPage.path, extra: meme);
  }
}
