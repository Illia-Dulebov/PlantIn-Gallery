import 'package:flutter/cupertino.dart';

class DialogModalWindow extends StatelessWidget {
  final String content;
  final VoidCallback? onConfirm;

  const DialogModalWindow({super.key, required this.content, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Alert'),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!();
            }
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
