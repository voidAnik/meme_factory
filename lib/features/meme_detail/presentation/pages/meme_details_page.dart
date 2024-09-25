import 'package:flutter/material.dart';
import 'package:meme_factory/core/constants/strings.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/features/meme_detail/presentation/widgets/signature_widget.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

class MemeDetailsPage extends StatelessWidget {
  const MemeDetailsPage({super.key, required this.meme});
  static const String path = '/movie_details_page';
  final Meme meme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.memeDetails,
            style: context.textStyle.titleMedium!.copyWith(
              fontSize: context.width * 0.05,
            )),
        centerTitle: true,
      ),
      body: _createBody(context),
    );
  }

  _createBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.5,
          width: context.width,
          child: Stack(
            children: [
              Image.network(meme.url!),
              const Align(
                alignment: Alignment.topRight,
                child: SignatureWidget(),
              )
            ],
          ),
        )
      ],
    );
  }
}
