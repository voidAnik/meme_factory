import 'package:flutter/material.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/widgets/network_image.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

class MemeGridItemWidget extends StatelessWidget {
  final Meme meme;
  final VoidCallback onPressed;
  const MemeGridItemWidget(
      {super.key, required this.onPressed, required this.meme});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 10.0,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(fit: StackFit.passthrough, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Hero(
              tag: meme.id!,
              child: CustomNetworkImage(
                imageUrl: meme.url!,
                width: context.width * 0.05,
                height: double.infinity,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0x00000000),
                  Color(0x00000000),
                  Color(0x66000000),
                  Color(0x66000000),
                ],
              ),
            ),
            child: Text(
              meme.name?.toUpperCase() ?? '',
              style: context.textStyle.titleSmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
