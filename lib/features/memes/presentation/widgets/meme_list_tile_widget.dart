import 'package:flutter/material.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/widgets/network_image.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

class MemeListTileWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Meme meme;

  const MemeListTileWidget(
      {super.key, required this.onPressed, required this.meme});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: meme.id!,
            child: CustomNetworkImage(
              imageUrl: meme.url!,
              width: context.width * 0.2,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(meme.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textStyle.titleSmall!.copyWith(fontSize: 12)),
        subtitle: Text(
          'Captions: ${meme.boxCount}',
          style: context.textStyle.bodySmall!.copyWith(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }
}
