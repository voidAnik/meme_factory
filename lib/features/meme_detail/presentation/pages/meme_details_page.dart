import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:meme_factory/core/constants/strings.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/injection/injection_container.dart';
import 'package:meme_factory/core/widgets/network_image.dart';
import 'package:meme_factory/features/meme_detail/blocs/edit_image_cubit.dart';
import 'package:meme_factory/features/meme_detail/presentation/widgets/signature_widget.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:permission_handler/permission_handler.dart';

class MemeDetailsPage extends StatelessWidget {
  const MemeDetailsPage({super.key, required this.meme});

  static const String path = '/movie_details_page';
  final Meme meme;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditImageCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.memeDetails,
                style: context.textStyle.titleMedium!.copyWith(
                  fontSize: context.width * 0.05,
                )),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Uint8List imageBytes = context.read<EditImageCubit>().state;
                    if (imageBytes.isNotEmpty) {
                      _saveImage(context, imageBytes);
                    }
                  },
                  icon: const Icon(Icons.save)),
            ],
          ),
          body: _createBody(context),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              _getImageBytes(meme.url!).then((bytes) {
                _editImage(context, bytes);
              });
            },
            label: Text(
              AppStrings.editImage,
              style: context.textStyle.titleMedium,
            ),
            icon: const Icon(Icons.edit),
          ),
        );
      }),
    );
  }

  _createBody(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.5,
          width: context.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlocBuilder<EditImageCubit, Uint8List>(
                builder: (context, editedImage) {
                  return editedImage.isEmpty
                      ? Hero(
                          tag: meme.id!,
                          child: CustomNetworkImage(
                            imageUrl: meme.url!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.memory(
                          editedImage,
                          fit: BoxFit.cover,
                        );
                },
              ),
              const Align(
                alignment: Alignment.topRight,
                child: SignatureWidget(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        _createInfoWidget(context),
      ],
    );
  }

  _createInfoWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          meme.name ?? '',
          textAlign: TextAlign.center,
          style: context.textStyle.headlineMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _columnItem(context,
                title: AppStrings.boxCount, value: meme.boxCount.toString()),
            _columnItem(context,
                title: AppStrings.captions, value: meme.captions.toString()),
          ],
        )
      ],
    );
  }

  Column _columnItem(BuildContext context,
      {required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: context.textStyle.bodyMedium!.copyWith(
            color: context.theme.colorScheme.secondaryFixedDim,
          ),
        ),
        Text(
          value,
          style: context.textStyle.titleMedium,
        ),
      ],
    );
  }

  void _editImage(BuildContext context, Uint8List imageData) {
    Navigator.push<Uint8List>(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: imageData,
          cropOption: const CropOption(
            reversible: false,
          ),
        ),
      ),
    ).then((Uint8List? newImage) {
      context.read<EditImageCubit>().updateImage(newImage ?? Uint8List(0));
    });
  }

  Future<Uint8List> _getImageBytes(String url) async {
    final response = await NetworkAssetBundle(Uri.parse(url)).load("");
    final bytes = response.buffer.asUint8List();
    return bytes;
  }

  Future<void> _saveImage(
      BuildContext context, Uint8List editedImageBytes) async {
    // Request storage permission
    await _requestPermission();

    // Let user pick a directory
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No directory selected')));
      return;
    }

    // Creating new file
    String filePath =
        '$selectedDirectory/my_edited_meme_${DateTime.now().millisecondsSinceEpoch}.png';
    File file = File(filePath);

    // Writing image bytes to the file
    await file.writeAsBytes(editedImageBytes);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Image saved to $filePath')));
  }

  // Request storage permissions
  Future<void> _requestPermission() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception("Permission not granted to save image");
    }
  }
}
