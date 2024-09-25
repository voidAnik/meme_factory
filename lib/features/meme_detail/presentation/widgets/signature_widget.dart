import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_factory/core/extensions/context_extension.dart';
import 'package:meme_factory/core/injection/injection_container.dart';
import 'package:meme_factory/features/meme_detail/blocs/signature_cubit.dart';
import 'package:meme_factory/features/meme_detail/presentation/widgets/signature_editor_dialog.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatefulWidget {
  const SignatureWidget({super.key});

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignatureCubit>(),
      child: BlocBuilder<SignatureCubit, Uint8List>(
        builder: (context, bytes) {
          return GestureDetector(
            onTap: () {
              openSignatureEditor(context);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              height: context.height * 0.15,
              width: context.width * 0.5,
              color: Colors.black.withOpacity(0.1),
              child: Stack(fit: StackFit.passthrough, children: [
                bytes.isNotEmpty ? Image.memory(bytes) : Container(),
                Align(
                    alignment: Alignment.topRight,
                    child: bytes.isNotEmpty
                        ? const Icon(Icons.edit)
                        : const Icon(Icons.add)),
              ]),
            ),
          );
        },
      ),
    );
  }

  void openSignatureEditor(BuildContext context) async {
    showDialog<Uint8List>(
      context: context,
      builder: (context) => SignatureEditorDialog(controller: _controller),
    ).then((newSignature) {
      if (newSignature != null) {
        context.read<SignatureCubit>().updateSignature(newSignature);
      }
    });
  }
}
