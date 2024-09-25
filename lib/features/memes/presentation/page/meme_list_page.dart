import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meme_factory/core/constants/strings.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/injection/injection_container.dart';
import 'package:meme_factory/features/meme_detail/presentation/pages/meme_details_page.dart';
import 'package:meme_factory/features/memes/blocs/meme_search_cubit.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:meme_factory/features/memes/presentation/widgets/meme_list_widget.dart';
import 'package:meme_factory/features/memes/presentation/widgets/meme_search_delegate.dart';

class MemeListPage extends StatelessWidget {
  static const String path = '/meme_list_page';

  const MemeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MemeSearchCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: _createAppBar(context),
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: _createBody(context),
        );
      }),
    );
  }

  AppBar _createAppBar(BuildContext context) {
    final searchCubit = context.read<MemeSearchCubit>();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Hero(
        tag: 'title',
        child: Text(
          AppStrings.title,
          style: GoogleFonts.aldrich(
              fontSize: context.width * 0.05, color: Colors.red),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(Icons.search,
                color: context.theme.appBarTheme.iconTheme!.color),
            onPressed: () {
              showSearch(
                  context: context, delegate: MemeSearchDelegate(searchCubit));
            },
          ),
        ),
      ],
      elevation: 0.0,
    );
  }

  _createBody(BuildContext context) {
    return MemeListWidget(onPressedMovie: (meme) {
      _navigateToMemeDetails(context, meme);
    });
  }

  void _navigateToMemeDetails(BuildContext context, Meme meme) {
    context.push(MemeDetailsPage.path, extra: meme);
  }
}
