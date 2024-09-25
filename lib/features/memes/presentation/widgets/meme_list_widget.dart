import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_factory/core/injection/injection_container.dart';
import 'package:meme_factory/core/widgets/error_widget.dart';
import 'package:meme_factory/features/memes/blocs/meme_data_state.dart';
import 'package:meme_factory/features/memes/blocs/meme_list_cubit.dart';
import 'package:meme_factory/features/memes/blocs/meme_search_cubit.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:meme_factory/features/memes/presentation/widgets/meme_grid_item_widget.dart';
import 'package:meme_factory/features/memes/presentation/widgets/shimmer_grid_item.dart';

class MemeListWidget extends StatelessWidget {
  final Function(Meme) onPressedMovie;
  const MemeListWidget({super.key, required this.onPressedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemeListCubit>()..getMemes(),
      child: _createView(context),
    );
  }

  _createView(BuildContext context) {
    return BlocBuilder<MemeListCubit, MemeDataState>(builder: (context, state) {
      log('state : $state');
      if (state is MemeInitial || state is MemeLoading) {
        return _createShimmerList(context, 10);
      } else if (state is MemeError) {
        return ErrorMessage(message: state.message);
      } else if (state is MemeLoaded) {
        final memes = state.memes;
        context.read<MemeSearchCubit>().loadMemes(memes);
        return _createMemeList(context, memes);
      } else {
        return const Spacer();
      }
    });
  }

  Widget _createMemeList(BuildContext context, List<Meme> memes) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            scrollInfo.metrics.axis == Axis.vertical) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            context.read<MemeListCubit>().loadMoreMemes();
          }
        }
        return true;
      },
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            childAspectRatio: 0.8),
        padding: const EdgeInsets.all(8.0), // padding around the grid
        itemCount: memes.length, // total number of items
        itemBuilder: (context, index) {
          return MemeGridItemWidget(
              meme: memes[index],
              onPressed: () => onPressedMovie(memes[index]));
        },
      ),
    );
  }

  Widget _createShimmerList(BuildContext context, int length) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            childAspectRatio: 0.8),
        padding: const EdgeInsets.all(8.0), // padding around the grid
        itemCount: length, // total number of items
        itemBuilder: (context, index) {
          return const ShimmerGridItem();
        },
      ),
    );
  }
}
