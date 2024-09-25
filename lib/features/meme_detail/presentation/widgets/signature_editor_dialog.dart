import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureEditorDialog extends StatefulWidget {
  final SignatureController controller;

  const SignatureEditorDialog({super.key, required this.controller});

  @override
  State<SignatureEditorDialog> createState() => _SignatureEditorDialogState();
}

class _SignatureEditorDialogState extends State<SignatureEditorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Signature canvas
            Signature(
              controller: widget.controller,
              height: 200,
              backgroundColor: Colors.grey[300]!,
            ),
            const SizedBox(height: 16),
            _createOptionIcons(context),
          ],
        ),
      ),
    );
  }

  Row _createOptionIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        //SHOW EXPORTED IMAGE IN NEW ROUTE
        IconButton(
          icon: const Icon(Icons.done),
          color: Colors.blue,
          onPressed: () {
            if (widget.controller.isNotEmpty) {
              widget.controller.toPngBytes().then((data) {
                Navigator.of(context).pop(data);
              });
            } else {
              Navigator.of(context).pop(Uint8List(0));
            }
          },
          tooltip: 'Save Signature',
        ),

        IconButton(
          icon: const Icon(Icons.undo),
          color: Colors.blue,
          onPressed: () {
            setState(() => widget.controller.undo());
          },
          tooltip: 'Undo',
        ),
        IconButton(
          icon: const Icon(Icons.redo),
          color: Colors.blue,
          onPressed: () {
            setState(() => widget.controller.redo());
          },
          tooltip: 'Redo',
        ),
        //CLEAR CANVAS
        IconButton(
          icon: const Icon(Icons.clear),
          color: Colors.blue,
          onPressed: () {
            setState(() => widget.controller.clear());
          },
          tooltip: 'Clear',
        ),
      ],
    );
  }
}
